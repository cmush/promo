defmodule PromoWeb.PromoCodeController do
  use PromoWeb, :controller

  alias Promo.PromoCodes
  alias Promo.PromoCodes.PromoCode
  alias HttpClient.GmapsClient

  action_fallback PromoWeb.FallbackController

  def index(conn, _params) do
    promo_codes = PromoCodes.list_promo_codes()
    render(conn, "index.json", promo_codes: promo_codes)
  end

  def create(conn, %{"promo_code" => promo_code_params}) do
    with {:ok, %PromoCode{} = promo_code} <- PromoCodes.create_promo_code(promo_code_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.promo_code_path(conn, :show, promo_code))
      |> render("show.json", promo_code: promo_code)
    end
  end

  def show(conn, %{"id" => id}) do
    promo_code = PromoCodes.get_promo_code!(id)
    render(conn, "show.json", promo_code: promo_code)
  end

  @spec show_where_status(Plug.Conn.t(), map) :: Plug.Conn.t()
  def show_where_status(conn, %{"status" => status}) do
    promo_codes = PromoCodes.list_promo_codes(status)
    render(conn, "index.json", promo_codes: promo_codes)
  end

  def update(conn, %{"id" => id, "promo_code" => promo_code_params}) do
    promo_code = PromoCodes.get_promo_code!(id)

    with {:ok, %PromoCode{} = promo_code} <-
           PromoCodes.update_promo_code(promo_code, promo_code_params) do
      render(conn, "show.json", promo_code: promo_code)
    end
  end

  def delete(conn, %{"id" => id}) do
    promo_code = PromoCodes.get_promo_code!(id)

    with {:ok, %PromoCode{}} <- PromoCodes.delete_promo_code(promo_code) do
      send_resp(conn, :no_content, "")
    end
  end

  @spec validate(Plug.Conn.t(), map) :: Plug.Conn.t()
  def validate(conn, request) do
    case validate(request) do
      :deactivated ->
        render(
          conn,
          "promo_code_invalid__status_inactive.json",
          promo_code: %{}
        )

      :expired ->
        render(
          conn,
          "promo_code_invalid__status_expired.json",
          promo_code: %{}
        )

      :travel_distance_exceeds_radius_allowed ->
        render(
          conn,
          "promo_code_invalid__travel_distance_exceeds_radius_allowed.json",
          promo_code: %{}
        )

      promo_code ->
        render(
          conn,
          "promo_code_valid.json",
          promo_code: promo_code
        )
    end
  end

  defp validate(%{
         "p_code" => p_code,
         "origin" => %{
           "latitude" => or_latitude,
           "longitude" => or_longitude,
           "place" => _or_place
         },
         "destination" => %{
           "latitude" => dest_latitude,
           "longitude" => dest_longitude,
           "place" => _dest_place
         }
       }) do
    promo_code = PromoCodes.get_promo_code_by_p_code(p_code)

    promo_code
    |> validate_status()
    |> validate_not_expired()
    |> validate_within_allowed_radius(
      # origin coordinates
      or_latitude <> "," <> or_longitude,
      # destination coordinates
      dest_latitude <> "," <> dest_longitude
    )
  end

  @spec validate_status(map) :: :deactivated | map
  def validate_status(promo_code) do
    case Map.get(promo_code, :status) do
      true -> promo_code
      false -> :deactivated
    end
  end

  @spec validate_not_expired(:deactivated | Promo.PromoCodes.PromoCode.t()) ::
          :deactivated | :expired | Promo.PromoCodes.PromoCode.t()
  def validate_not_expired(:deactivated), do: :deactivated

  def validate_not_expired(%PromoCode{expiry_date: expiry_date} = promo_code) do
    if Date.diff(expiry_date, Date.utc_today()) >= 0 do
      promo_code
    else
      :expired
    end
  end

  @spec validate_within_allowed_radius(
          :deactivated | :expired | Promo.PromoCodes.PromoCode.t(),
          any,
          any
        ) ::
          :deactivated
          | :expired
          | :travel_distance_exceeds_radius_allowed
          | Promo.PromoCodes.PromoCode.t()
  def validate_within_allowed_radius(:deactivated, _origin, _destination), do: :deactivated
  def validate_within_allowed_radius(:expired, _origin, _destination), do: :expired

  def validate_within_allowed_radius(
        %PromoCode{radius: allowed_radius} = promo_code,
        origin,
        destination
      ) do
    %{
      "distance" => distance_from_destination,
      # overview polyline
      "polyline" => polyline
    } = get_distance_and_polyline(origin, destination)

    case distance_from_destination <= allowed_radius do
      false -> Map.put(promo_code, :polyline, polyline)
      true -> :travel_distance_exceeds_radius_allowed
    end
  end

  @spec get_distance_and_polyline(any, any) :: %{optional(<<_::64>>) => any}
  def get_distance_and_polyline(origin, destination) do
    resp = GmapsClient.fetch_directions(origin, destination)
    [routes] = resp.routes
    [legs] = routes.legs

    %{
      "distance" => meters_to_kilometers(legs.distance.value),
      "polyline" => routes.overview_polyline
    }
  end

  @spec meters_to_kilometers(number) :: float
  def meters_to_kilometers(distance_in_meters) do
    Float.round(distance_in_meters / 1000, 1)
  end
end

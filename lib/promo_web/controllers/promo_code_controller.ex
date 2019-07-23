defmodule PromoWeb.PromoCodeController do
  require Logger
  use PromoWeb, :controller

  alias Promo.{
    PromoCodes,
    PromoCodes.PromoCode
  }

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
    with(%PromoCode{} = promo_code <- validate(request)) do
      render(
        conn,
        "validation_result.json",
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
    # promo_code
    PromoCodes.get_promo_code_by_p_code(p_code)
    |> validate_state()
    |> validate_not_expired()
    |> validate_within_allowed_radius(
      # origin coordinates
      or_latitude <> "," <> or_longitude,
      # destination coordinates
      dest_latitude <> "," <> dest_longitude
    )
  end

  @spec validate_state(map) :: :deactivated | map
  def validate_state(promo_code) do
    case Map.get(promo_code, :status) do
      true -> promo_code
      false -> :deactivated
    end
  end

  @spec validate_not_expired(any) :: any
  def validate_not_expired(%PromoCode{expiry_date: expiry_date} = promo_code) do
    if Date.diff(expiry_date, Date.utc_today()) >= 0 do
      promo_code
    else
      :expired
    end
  end

  def validate_not_expired(state), do: state

  @spec validate_within_allowed_radius(any, any, any) :: any
  def validate_within_allowed_radius(
        %PromoCode{radius: allowed_radius} = promo_code,
        origin,
        destination
      ) do
    %{
      "distance" => distance_to_destination,
      # overview polyline
      "polyline" => polyline
    } = get_distance_and_polyline(origin, destination)

    Logger.debug("distance_to_destination: #{inspect(distance_to_destination)}")
    Logger.debug("allowed_radius: #{inspect(allowed_radius)}")

    allowed = distance_to_destination > allowed_radius
    Logger.debug("distance_to_destination > allowed_radius?: #{inspect(allowed)}")

    if allowed do
      :distance_to_cover_exceeds_radius_allowed
    else
      Map.put(promo_code, :polyline, polyline)
    end
  end

  def validate_within_allowed_radius(state, _origin, _destination), do: state

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

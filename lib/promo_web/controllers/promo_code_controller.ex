defmodule PromoWeb.PromoCodeController do
  use PromoWeb, :controller

  alias Promo.PromoCodes
  alias Promo.PromoCodes.PromoCode

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

  def validate(conn, %{"p_code" => p_code, "origin" => origin, "destination" => destination}) do
    promo_code = PromoCodes.get_promo_code_by_p_code(p_code)

    promo_code
    |> validate_status()
    |> validate_not_expired()
    |> validate_within_allowed_radius(origin, destination)
    |> case do
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

  def validate_status(promo_code) do
    case Map.get(promo_code, :status) do
      true -> promo_code
      false -> :deactivated
    end
  end

  def validate_not_expired(:deactivated), do: :deactivated

  def validate_not_expired(%PromoCode{expiry_date: expiry_date} = promo_code) do
    if Date.diff(expiry_date, Date.utc_today()) >= 0 do
      promo_code
    else
      :expired
    end
  end

  def validate_within_allowed_radius(:deactivated, _origin, _destination), do: :deactivated
  def validate_within_allowed_radius(:expired, _origin, _destination), do: :expired

  def validate_within_allowed_radius(
        %PromoCode{radius: allowed_radius} = promo_code,
        origin,
        destination
      ) do
    %{
      "radius" => distance_from_destination,
      "polyline" => polyline
    } = gmaps_api_fetch_polyline(origin, destination)

    case distance_from_destination <= allowed_radius do
      false -> Map.put(promo_code, :polyline, polyline)
      true -> :travel_distance_exceeds_radius_allowed
    end
  end

  def gmaps_api_fetch_polyline(_origin, _destination) do
    %{
      # TODO: sample hard coded radius & polyline
      "radius" => 3.5,
      "polyline" => "sample polyline"
    }
  end
end

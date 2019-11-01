defmodule PromoWeb.PromoCodeController do
  use PromoWeb, :controller

  alias Promo.{PromoCodes, EventLocations}
  alias Promo.{PromoCodes.PromoCode, EventLocations.EventLocation}

  action_fallback PromoWeb.FallbackController

  def index(conn, %{"validity" => "active"}) do
    promo_codes = PromoCodes.list_valid_promo_codes()
    render(conn, "index.json", promo_codes: promo_codes)
  end

  def index(conn, _params) do
    promo_codes = PromoCodes.list_promo_codes()
    render(conn, "index.json", promo_codes: promo_codes)
  end

  def create(conn, %{
        "promo_code" => %{"event_location" => event_location_params} = promo_code_params
      }) do
    case EventLocations.create_event_location(event_location_params) do
      {:ok, %EventLocation{} = event_location} ->
        # The location supplied is successfully created,
        # its id is then used to generate a promo code
        create_promo_code(conn, promo_code_params, event_location.id)

      _error ->
        # if an error occurs during event location creation,
        # it's probably because the place/venue already exists in event_locations
        # fetch the event_location and use its id to generate a new promo code
        [%EventLocation{id: event_location_id}] =
          EventLocations.get_event_location_by_place!(Map.get(event_location_params, "place"))

        create_promo_code(conn, promo_code_params, event_location_id)
    end
  end

  defp create_promo_code(conn, promo_code_params, event_location_id) do
    promo_code_params =
      promo_code_params
      |> Map.put("p_code", code_prefix() <> "-" <> random_string(5))
      |> Map.put("event_location_id", event_location_id)

    with {:ok, %PromoCode{} = promo_code} <-
           PromoCodes.create_promo_code(promo_code_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.promo_code_path(conn, :show, promo_code))
      |> render("show.json", promo_code: promo_code)
    end
  end

  def random_string(length) do
    :crypto.strong_rand_bytes(length) |> Base.url_encode64() |> binary_part(0, length)
  end

  def code_prefix do
    # TODO: should be fetched from the db, should be configurable on admin dashboard
    "KaziSafe"
  end

  def show(conn, %{"id" => id}) do
    promo_code = PromoCodes.get_promo_code!(id)
    render(conn, "show.json", promo_code: promo_code)
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
end

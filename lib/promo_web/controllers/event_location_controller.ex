defmodule PromoWeb.EventLocationController do
  use PromoWeb, :controller

  alias Promo.EventLocations
  alias Promo.EventLocations.EventLocation

  action_fallback PromoWeb.FallbackController

  def index(conn, _params) do
    event_locations = EventLocations.list_event_locations()
    render(conn, "index.json", event_locations: event_locations)
  end

  def create(conn, %{"event_location" => event_location_params}) do
    with {:ok, %EventLocation{} = event_location} <- EventLocations.create_event_location(event_location_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.event_location_path(conn, :show, event_location))
      |> render("show.json", event_location: event_location)
    end
  end

  def show(conn, %{"id" => id}) do
    event_location = EventLocations.get_event_location!(id)
    render(conn, "show.json", event_location: event_location)
  end

  def update(conn, %{"id" => id, "event_location" => event_location_params}) do
    event_location = EventLocations.get_event_location!(id)

    with {:ok, %EventLocation{} = event_location} <- EventLocations.update_event_location(event_location, event_location_params) do
      render(conn, "show.json", event_location: event_location)
    end
  end

  def delete(conn, %{"id" => id}) do
    event_location = EventLocations.get_event_location!(id)

    with {:ok, %EventLocation{}} <- EventLocations.delete_event_location(event_location) do
      send_resp(conn, :no_content, "")
    end
  end
end

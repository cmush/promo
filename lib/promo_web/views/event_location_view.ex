defmodule PromoWeb.EventLocationView do
  use PromoWeb, :view
  alias PromoWeb.EventLocationView

  def render("index.json", %{event_locations: event_locations}) do
    %{data: render_many(event_locations, EventLocationView, "event_location.json")}
  end

  def render("show.json", %{event_location: event_location}) do
    %{data: render_one(event_location, EventLocationView, "event_location.json")}
  end

  def render("event_location.json", %{event_location: event_location}) do
    %{id: event_location.id,
      place: event_location.place,
      latitude: event_location.latitude,
      longitude: event_location.longitude}
  end
end

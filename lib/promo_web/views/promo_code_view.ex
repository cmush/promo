defmodule PromoWeb.PromoCodeView do
  use PromoWeb, :view
  alias PromoWeb.PromoCodeView

  def render("index.json", %{promo_codes: promo_codes}) do
    %{data: render_many(promo_codes, PromoCodeView, "promo_code.json")}
  end

  def render("show.json", %{promo_code: promo_code}) do
    %{data: render_one(promo_code, PromoCodeView, "promo_code.json")}
  end

  def render("promo_code.json", %{promo_code: promo_code}) do
    %{
      id: promo_code.id,
      p_code: promo_code.p_code,
      amount: promo_code.amount,
      expiry_date: promo_code.expiry_date,
      status: promo_code.status,
      radius: promo_code.radius,
      event_location_id: promo_code.event_location_id
    }
  end

  def render("index_with_event_location.json", %{promo_codes: promo_codes}) do
    %{data: render_many(promo_codes, PromoCodeView, "promo_code_with_event_location.json")}
  end

  def render("show_with_event_location.json", %{promo_code: promo_code}) do
    %{data: render_one(promo_code, PromoCodeView, "promo_code_with_event_location.json")}
  end

  def render("promo_code_with_event_location.json", %{
        promo_code: %{event_locations: event_locations} = promo_code
      }) do
    %{
      id: promo_code.id,
      p_code: promo_code.p_code,
      amount: promo_code.amount,
      expiry_date: promo_code.expiry_date,
      status: promo_code.status,
      radius: promo_code.radius,
      event_location: %{
        place: event_locations.place,
        latitude: event_locations.latitude,
        longitude: event_locations.longitude
      }
    }
  end

  def render("show_with_event_location_distance_and_polyline.json", %{promo_code: promo_code}) do
    %{
      data:
        render_one(
          promo_code,
          PromoCodeView,
          "promo_code_with_event_location_distance_and_polyline.json"
        )
    }
  end

  def render("promo_code_with_event_location_distance_and_polyline.json", %{
        promo_code: %{event_locations: event_locations} = promo_code
      }) do
    %{
      id: promo_code.id,
      p_code: promo_code.p_code,
      amount: promo_code.amount,
      expiry_date: promo_code.expiry_date,
      status: promo_code.status,
      radius: promo_code.radius,
      polyline: promo_code.polyline,
      distance_to_destination: promo_code.distance_to_destination,
      event_location: %{
        place: event_locations.place,
        latitude: event_locations.latitude,
        longitude: event_locations.longitude
      }
    }
  end
end

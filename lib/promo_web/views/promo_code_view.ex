defmodule PromoWeb.PromoCodeView do
  use PromoWeb, :view
  alias PromoWeb.PromoCodeView

  def render("index.json", %{promo_codes: promo_codes}) do
    %{data: render_many(promo_codes, PromoCodeView, "promo_code.json")}
  end

  def render("show.json", %{promo_code: promo_code}) do
    %{data: render_one(promo_code, PromoCodeView, "promo_code.json")}
  end

  def render("validation_result.json", %{promo_code: promo_code}) do
    %{data: render_one(promo_code, PromoCodeView, "validation_result__code_valid.json")}
  end

  def render("promo_code.json", %{promo_code: promo_code}) do
    %{
      id: promo_code.id,
      p_code: promo_code.p_code,
      ride_amount: promo_code.ride_amount,
      expiry_date: promo_code.expiry_date,
      status: promo_code.status,
      radius: promo_code.radius
    }
  end

  def render("validation_result__code_valid.json", %{promo_code: promo_code}) do
    %{
      id: promo_code.id,
      p_code: promo_code.p_code,
      ride_amount: promo_code.ride_amount,
      expiry_date: promo_code.expiry_date,
      status: promo_code.status,
      radius: promo_code.radius,
      polyline: promo_code.polyline
    }
  end
end

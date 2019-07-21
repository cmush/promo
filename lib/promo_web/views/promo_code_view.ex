defmodule PromoWeb.PromoCodeView do
  use PromoWeb, :view
  alias PromoWeb.PromoCodeView

  def render("index.json", %{promo_codes: promo_codes}) do
    %{data: render_many(promo_codes, PromoCodeView, "promo_code.json")}
  end

  def render("show.json", %{promo_code: promo_code}) do
    %{data: render_one(promo_code, PromoCodeView, "promo_code.json")}
  end

  def render("promo_code_valid.json", %{promo_code: promo_code}) do
    %{data: render_one(promo_code, PromoCodeView, "valid_promo_code.json")}
  end

  def render("promo_code_invalid__status_inactive.json", %{promo_code: _promo_code}) do
    %{error: "promo_code_invalid__status_inactive"}
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

  def render("valid_promo_code.json", %{promo_code: promo_code}) do
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

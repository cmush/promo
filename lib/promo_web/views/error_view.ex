defmodule PromoWeb.ErrorView do
  use PromoWeb, :view

  # If you want to customize a particular status code
  # for a certain format, you may uncomment below.
  # def render("500.json", _assigns) do
  #   %{errors: %{detail: "Internal Server Error"}}
  # end

  # By default, Phoenix returns the status message from
  # the template name. For example, "404.json" becomes
  # "Not Found".
  def template_not_found(template, _assigns) do
    %{errors: %{detail: Phoenix.Controller.status_message_from_template(template)}}
  end

  def render("promo_code_invalid__status_inactive.json", %{promo_code: _promo_code}) do
    %{error: "promo_code_invalid__status_inactive"}
  end

  def render("promo_code_invalid__status_expired.json", %{promo_code: _promo_code}) do
    %{error: "promo_code_invalid__status_expired"}
  end

  def render("promo_code_invalid__travel_distance_exceeds_radius_allowed.json", %{
        promo_code: _promo_code
      }) do
    %{error: "promo_code_invalid__travel_distance_exceeds_radius_allowed"}
  end

  def render("promo_code_invalid__ride_amount_exceeded.json", %{promo_code: _promo_code}) do
    %{error: "promo_code_invalid__ride_amount_exceeded"}
  end

  def render("400.json", _) do
    %{
      errors: %{
        detail:
          "Bad Request! e.g, a missing field. Kindly refer to the documentation/postman collection and comprare with your current request"
      }
    }
  end

  def render("404.json", _assigns) do
    %{errors: %{detail: "Endpoint not found!"}}
  end

  def render("500.json", _assigns) do
    %{errors: %{detail: "Internal server error :("}}
  end
end

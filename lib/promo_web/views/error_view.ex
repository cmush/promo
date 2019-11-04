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

  def render("valid_promo_code_not_found_error.json", _) do
    %{
      error:
        "supplied promo_code is either nonexistent or invalid (i.e, expired, deactivated or not allowed for destination due to cost or distance constraints) "
    }
  end

  def render("origin_or_destination_not_equal_to_event.json", _) do
    %{
      error:
        "supplied promo_code is not valid for specified journey: origin or destination should match event location"
    }
  end

  def render("distance_to_cover_exceeds_radius_allowed.json", %{distance_exceeded: distance_exceeded}) do
    %{
      error:
        "distance to cover exceeds promo_code's allowed radius by #{distance_exceeded} Kilometers. A cash topup perhaps?"
    }
  end
end

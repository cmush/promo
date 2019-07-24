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

  def render("404.json", _assigns) do
    %{errors: %{detail: "Endpoint not found!"}}
  end

  def render("500.json", _assigns) do
    %{errors: %{detail: "Internal server error :("}}
  end

  def render("validation_error.json", %{state: state}), do: validation_error(state)

  @spec validation_error(
          :deactivated
          | :distance_to_cover_exceeds_radius_allowed
          | :estimated_fare_exceeds_ride_amount
          | :expired
        ) :: %{error: <<_::64, _::_*8>>}
  def validation_error(:deactivated) do
    %{error: "promo_code_invalid__status_inactive"}
  end

  def validation_error(:expired) do
    %{error: "promo_code_invalid__status_expired"}
  end

  def validation_error(:distance_to_cover_exceeds_radius_allowed) do
    %{error: "promo_code_invalid__travel_distance_exceeds_radius_allowed"}
  end

  def validation_error(:estimated_fare_exceeds_ride_amount) do
    %{error: "promo_code_invalid__allowed_ride_amount_exceeded"}
  end
end

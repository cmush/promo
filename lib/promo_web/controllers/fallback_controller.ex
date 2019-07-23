defmodule PromoWeb.FallbackController do
  @moduledoc """
  Translates controller action results into valid `Plug.Conn` responses.

  See `Phoenix.Controller.action_fallback/1` for more details.
  """
  use PromoWeb, :controller

  def call(conn, {:error, %Ecto.Changeset{} = changeset}) do
    conn
    |> put_status(:unprocessable_entity)
    |> put_view(PromoWeb.ChangesetView)
    |> render("error.json", changeset: changeset)
  end

  def call(conn, {:error, :not_found}) do
    conn
    |> put_status(:not_found)
    |> put_view(PromoWeb.ErrorView)
    |> render(:"404")
  end

  def call(conn, _) do
    conn
    |> put_status(:bad_request)
    |> put_view(PromoWeb.ErrorView)
    |> render(:"400")
  end
end

#   :deactivated ->
#     render(
#       conn,
#       "promo_code_invalid__status_inactive.json",
#       promo_code: %{}
#     )

#   :expired ->
#     render(
#       conn,
#       "promo_code_invalid__status_expired.json",
#       promo_code: %{}
#     )

#   :travel_distance_exceeds_radius_allowed ->
#     render(
#       conn,
#       "promo_code_invalid__travel_distance_exceeds_radius_allowed.json",
#       promo_code: %{}
#     )

#   promo_code ->
#     render(
#       conn,
#       "promo_code_valid.json",
#       promo_code: promo_code
#     )
# end

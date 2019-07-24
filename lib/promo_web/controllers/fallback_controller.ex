defmodule PromoWeb.FallbackController do
  @moduledoc """
  Translates controller action results into valid `Plug.Conn` responses.

  See `Phoenix.Controller.action_fallback/1` for more details.
  """
  use PromoWeb, :controller

  @promo_validate_state [:deactivated, :expired, :distance_to_cover_exceeds_radius_allowed]

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

  def call(conn, state) when state in @promo_validate_state do
    conn
    |> put_status(203)
    |> put_view(PromoWeb.ErrorView)
    |> render("validation_error.json", state: state)
  end
end

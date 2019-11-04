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

  def call(conn, {:error, :nil_place}) do
    conn
    |> put_status(:unprocessable_entity)
    |> put_view(PromoWeb.ErrorView)
    |> render(:"422")
  end

  def call(conn, {:error, :promo_code_not_found}) do
    conn
    |> put_status(:not_found)
    |> put_view(PromoWeb.ErrorView)
    |> render(:"404")
  end

  def call(conn, {:error, :valid_promo_code_not_found}) do
    conn
    |> put_status(:not_found)
    |> put_view(PromoWeb.ErrorView)
    |> render("valid_promo_code_not_found_error.json")
  end

  def call(conn, {:error, :origin_or_destination_not_equal_to_event}) do
    conn
    |> put_status(:not_found)
    |> put_view(PromoWeb.ErrorView)
    |> render("origin_or_destination_not_equal_to_event.json")
  end

  def call(conn, {:error, :distance_to_cover_exceeds_radius_allowed, distance_exceeded}) do
    conn
    |> put_status(:not_found)
    |> put_view(PromoWeb.ErrorView)
    |> render("distance_to_cover_exceeds_radius_allowed.json",
      distance_exceeded: distance_exceeded
    )
  end
end

defmodule PromoWeb.PromoCodeController do
  use PromoWeb, :controller

  alias Promo.PromoCodes
  alias Promo.PromoCodes.PromoCode

  action_fallback PromoWeb.FallbackController

  def index(conn, _params) do
    promo_codes = PromoCodes.list_promo_codes()
    render(conn, "index.json", promo_codes: promo_codes)
  end

  def create(conn, %{"promo_code" => promo_code_params}) do
    with {:ok, %PromoCode{} = promo_code} <- PromoCodes.create_promo_code(promo_code_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.promo_code_path(conn, :show, promo_code))
      |> render("show.json", promo_code: promo_code)
    end
  end

  def show(conn, %{"id" => id}) do
    promo_code = PromoCodes.get_promo_code!(id)
    render(conn, "show.json", promo_code: promo_code)
  end

  def show_where_status(conn, %{"status" => status}) do
    promo_codes = PromoCodes.list_promo_codes(status)
    render(conn, "index.json", promo_codes: promo_codes)
  end

  def update(conn, %{"id" => id, "promo_code" => promo_code_params}) do
    promo_code = PromoCodes.get_promo_code!(id)

    with {:ok, %PromoCode{} = promo_code} <-
           PromoCodes.update_promo_code(promo_code, promo_code_params) do
      render(conn, "show.json", promo_code: promo_code)
    end
  end

  def delete(conn, %{"id" => id}) do
    promo_code = PromoCodes.get_promo_code!(id)

    with {:ok, %PromoCode{}} <- PromoCodes.delete_promo_code(promo_code) do
      send_resp(conn, :no_content, "")
    end
  end

  def validate(conn, %{"p_code" => p_code, "origin" => origin, "destination" => destination}) do
    promo_code = PromoCodes.get_promo_code_by_p_code(p_code)
    case Map.get(promo_code, :status) do
      true ->
        render(
          conn,
          "promo_code_valid.json",
          promo_code: Map.put(promo_code, :polyline, fetch_polyline(origin, destination))
        )
        false ->
          render(
          conn,
          "promo_code_invalid__status_inactive.json",
          promo_code: Map.put(promo_code, :polyline, fetch_polyline(origin, destination))
        )
    end
  end

  def fetch_polyline(_origin, _destination) do
    "dummy polyline"
  end
end

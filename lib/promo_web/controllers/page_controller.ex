defmodule PromoWeb.PageController do
  use PromoWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end

defmodule PromoWeb.Router do
  use PromoWeb, :router
  use Pow.Phoenix.Router

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :protected do
    plug Pow.Plug.RequireAuthenticated,
         error_handler: Pow.Phoenix.PlugErrorHandler
  end

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  scope "/" do
    pipe_through :browser

    pow_routes()
  end

  scope "/", PromoWeb do
    pipe_through [:browser, :protected]

    # Add your protected routes here
  end

  scope "/api", PromoWeb do
    pipe_through :api

    resources "/event_locations", EventLocationController, except: [:new, :edit]

    get "/promo_codes", PromoCodeController, :index
    post "/promo_codes", PromoCodeController, :create
    get "/promo_codes/:id", PromoCodeController, :show
    post "/promo_codes/validate", PromoCodeController, :validate
    post "/promo_codes/radius/:p_code", PromoCodeController, :radius
    post "/promo_codes/deactivate/:p_code", PromoCodeController, :deactivate
    post "/promo_codes/check_validity/:p_code", PromoCodeController, :check_validity
    patch "/promo_codes/:id", PromoCodeController, :update
    put "/promo_codes/:id", PromoCodeController, :update
    delete "/promo_codes/:id", PromoCodeController, :delete
  end
end

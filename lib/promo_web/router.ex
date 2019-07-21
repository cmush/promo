defmodule PromoWeb.Router do
  use PromoWeb, :router
  use Pow.Phoenix.Router

  # pipelines
  pipeline :api do
    plug :accepts, ["json"]
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

  scope "/api", PromoWeb do
    pipe_through :api
    post "/promo_codes", PromoCodeController, :create, except: [:new, :edit]
    post "/promo_codes/validate", PromoCodeController, :validate, except: [:new, :edit]
    get "/promo_codes", PromoCodeController, :index, except: [:new, :edit]
    get "/promo_codes/:id", PromoCodeController, :show, except: [:new, :edit]
    get "/promo_codes/status/:status", PromoCodeController, :show_where_status
    patch "/promo_codes/:id", PromoCodeController, :update, except: [:new, :edit]
    put "/promo_codes/:id", PromoCodeController, :update, except: [:new, :edit]
    delete "/promo_codes/:id", PromoCodeController, :delete, except: [:new, :edit]
  end
end

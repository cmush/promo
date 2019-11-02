defmodule PromoWeb.Router do
  use PromoWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", PromoWeb do
    pipe_through :api

    resources "/event_locations", EventLocationController, except: [:new, :edit]

    get "/promo_codes", PromoCodeController, :index
    post "/promo_codes", PromoCodeController, :create
    get "/promo_codes/:id", PromoCodeController, :show
    post "/promo_codes/validate", PromoCodeController, :validate
    post "/promo_codes/deactivate/:p_code", PromoCodeController, :deactivate
    patch "/promo_codes/:id", PromoCodeController, :update
    put "/promo_codes/:id", PromoCodeController, :update
    delete "/promo_codes/:id", PromoCodeController, :delete
  end
end

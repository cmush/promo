defmodule PromoWeb.Router do
  use PromoWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
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

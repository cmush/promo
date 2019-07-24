defmodule PromoWeb.Router do
  use PromoWeb, :router
  use Pow.Phoenix.Router
  use PhoenixOauth2Provider.Router, otp_app: :promo

  # pipelines
  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :protected do
    plug Pow.Plug.RequireAuthenticated,
      error_handler: Pow.Phoenix.PlugErrorHandler
  end

  pipeline :api_protected do
    plug ExOauth2Provider.Plug.VerifyHeader, otp_app: :promo, realm: "Bearer"
    plug ExOauth2Provider.Plug.EnsureAuthenticated
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

  scope "/" do
    pipe_through [:browser, :protected]

    oauth_routes()
  end

  scope "/", PromoWeb do
    pipe_through :browser

    get "/", PageController, :index
  end

  scope "/" do
    pipe_through :api

    oauth_api_routes()
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

  scope "/api/v1", PromoWeb.API.V1 do
    pipe_through [:api, :api_protected]

    resources "/accounts", UserController
  end

  # Swagger stuff
  scope "/api/swagger" do
    forward "/", PhoenixSwagger.Plug.SwaggerUI, otp_app: :promo, swagger_file: "swagger.json"
  end

  def swagger_info do
    %{
      info: %{
        version: Application.spec(:promo, :vsn),
        title: "Promo"
      }
    }
  end
end

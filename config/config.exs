# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :promo,
  ecto_repos: [Promo.Repo],
  gmaps_client_config: %{
    :base_url__directions => System.get_env("BASE_URL_DIRECTIONS"),
    :base_url__distance_matrix => System.get_env("BASE_URL_DISTANCE_MATRIX"),
    :api_key => System.get_env("GMAPS_API_KEY")
  }

# Configures the endpoint
config :promo, PromoWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "+3Ki8Jygk1ogSEag3mXmgEwYcd2GNd/Qo8ri07lHh66LjSF9gsrFpf+i6XfFtgal",
  render_errors: [view: PromoWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: Promo.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"

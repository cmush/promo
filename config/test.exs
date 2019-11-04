use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :promo, PromoWeb.Endpoint,
  http: [port: 4002],
  server: false

config :promo,
  gmaps_client_config: %{
    :base_url__directions => "http://localhost:8081/destination/json",
    :base_url__distance_matrix => "",
    :api_key => "gmaps_api_key"
  }

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :promo, Promo.Repo,
  username: "postgres",
  password: "postgres",
  database: "promo_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

ExUnit.start()
Ecto.Adapters.SQL.Sandbox.mode(Promo.Repo, :manual)

{:ok, gmaps_mock} = Plug.Cowboy.http(HttpClient.MockServer, [], port: 8081)

IO.inspect(gmaps_mock,
  label:
    "GMaps Mock `HttpClient.MockServer` running as process #{inspect(gmaps_mock)} on port 8081"
)

# https://github.com/api-hogs/bureaucrat#configuration
Bureaucrat.start(
  default_path: "API.md",
  titles: [
    {PromoWeb.PromoCodeController, "API /promo_codes"}
  ],
  env_var: "DOC"
)

ExUnit.start(formatters: [ExUnit.CLIFormatter, Bureaucrat.Formatter])

ExUnit.start()
Ecto.Adapters.SQL.Sandbox.mode(Promo.Repo, :manual)

# https://github.com/api-hogs/bureaucrat#configuration
Bureaucrat.start(
  default_path: "API.md",
  titles: [
    {PromoWeb.PromoCodeController, "API /promo_codes"}
  ],
  env_var: "DOC"
)

ExUnit.start(formatters: [ExUnit.CLIFormatter, Bureaucrat.Formatter])

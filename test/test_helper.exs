ExUnit.start()
Ecto.Adapters.SQL.Sandbox.mode(Promo.Repo, :manual)

# https://github.com/api-hogs/bureaucrat#configuration
Bureaucrat.start(
  default_path: "API.md"
)
ExUnit.start(formatters: [ExUnit.CLIFormatter, Bureaucrat.Formatter])

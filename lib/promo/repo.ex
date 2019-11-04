defmodule Promo.Repo do
  use Ecto.Repo,
    otp_app: :promo,
    adapter: Ecto.Adapters.Postgres,
    ssl: true

  @spec init(any, keyword) :: {:ok, [{atom, any}, ...]}
  def init(_type, config) do
    {:ok, Keyword.put(config, :url, System.get_env("DATABASE_URL"))}
  end
end

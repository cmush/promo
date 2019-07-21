defmodule HttpClient.GmapsClient do
  use GenServer
  alias HttpClient.Api
  alias HttpClient.Utils
  def start_link(config) do
    GenServer.start_link(__MODULE__, config, name: :gmaps_http_client)
  end

  # GenServer Callbacks
  def init(config), do: {:ok, config}

  def fetch_distance_matrix(_origin, _destination) do

  end

  def distance_matrix_request(params) do
    params
    |> Utils.url(:base_url__distance_matrix)
    |> Api.get()
    |> Utils.http_resp_ok?()
  end

  def fetch_directions(_origin, _destination) do

  end

  def directions_request(params) do
    params
    |> Utils.url(:base_url__directions)
    |> Api.get()
    |> Utils.http_resp_ok?()
  end
end


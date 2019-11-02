defmodule HttpClient.GmapsClient do
  require Logger
  use GenServer
  alias HttpClient.Api
  alias HttpClient.Utils

  def start_link(config) do
    Logger.info("GmapsClient starting")
    Logger.debug("GmapsClient config: #{inspect(config)}")
    GenServer.start_link(__MODULE__, config, name: :gmaps_http_client)
  end

  # GenServer Callbacks
  def init(config) do
    Logger.debug("GmapsClient running")
    {:ok, config}
  end

  def fetch_distance_matrix(_origin, _destination) do
  end

  def distance_matrix_request(params) do
    params
    |> Utils.url(:base_url__distance_matrix)
    |> Api.get()
    |> Utils.http_resp_ok?()
  end

  def fetch_directions(origin, destination) do
    Logger.debug("GmapsClient fetch_directions/2
      origin: #{inspect(origin)}
      destination: #{inspect(destination)}")

    directions_request(%{
      :origin => origin,
      :destination => destination,
      :key => HttpClient.Utils.api_key()
    })
  end

  def directions_request(params) do
    response =
      params
      |> Utils.url(:base_url__directions)
      |> Api.get()
      |> Utils.http_resp_ok?()

    Logger.debug("GmapsClient directions_request/1 response: #{inspect(response)}")

    response
  end
end

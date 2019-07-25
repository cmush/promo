defmodule HttpClient.Utils do
  def base_url__directions do
    %{base_url__directions: base_url__directions} =
      Application.get_env(:promo, :gmaps_client_config)

    base_url__directions
  end

  def base_url__distance_matrix do
    %{base_url__distance_matrix: base_url__distance_matrix} =
      Application.get_env(:promo, :gmaps_client_config)

    base_url__distance_matrix
  end

  def api_key do
    %{api_key: api_key} = Application.get_env(:promo, :gmaps_client_config)
    api_key
  end

  # Generate a request's url by building on the base_url
  # def url(:base_url__directions), do: url(:base_url__directions, [])
  # def url(:base_url__distance_matrix), do: url(:base_url__distance_matrix, [])

  def url([], :base_url__directions), do: base_url__directions()
  def url(:error, :base_url__directions), do: :no_new_page

  def url(params, :base_url__directions) when is_binary(params),
    do: base_url__directions() <> "?" <> params

  def url(params, :base_url__directions) when is_map(params),
    do: base_url__directions() <> query_params(params)

  def url([], :base_url__distance_matrix), do: base_url__distance_matrix()
  def url(:error, :base_url__distance_matrix), do: :no_new_page

  def url(params, :base_url__distance_matrix) when is_binary(params),
    do: base_url__distance_matrix() <> "?" <> params

  def url(params, :base_url__distance_matrix) when is_map(params),
    do: base_url__distance_matrix() <> query_params(params)

  # Generate a url query string based on map inputs
  ## Examples
  #   iex> HTTP.utils(%{
  #         :key => "sting_value"
  #       })
  def query_params(params) when is_map(params) do
    Enum.reduce(
      params,
      "?",
      fn param, acc ->
        case pair(param) do
          pair when is_binary(pair) ->
            acc <> pair <> "&"

          pair when is_list(pair) ->
            acc
        end
      end
    )
  end

  @spec pair({atom, binary | integer}) :: <<_::8, _::_*8>>
  def pair({_, ""}), do: ""

  def pair({key, value}) when is_atom(key) and is_binary(value) do
    Atom.to_string(key) <> "=" <> value
  end

  def pair({key, value}) when is_atom(key) and is_integer(value) do
    Atom.to_string(key) <> "=" <> Integer.to_string(value)
  end

  def pair({:items, value}) when is_list(value), do: value

  # Check HTTP response is good for further processing based on code
  def http_resp_ok?({200, resp_body}), do: resp_body
  def http_resp_ok?({400, error_message}), do: {:bad_request, error_message}

  def http_resp_ok?({:error, "service unavailable"}),
    do: {:service_unavailable, "service unavailable"}

  def http_resp_ok?({code, error_message}) do
    IO.inspect(code, label: "TODO: handle error code")
    {:error, error_message}
  end
end

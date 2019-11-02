defmodule HttpClient.Api do
  @moduledoc false

  @doc """
    Send a GET request to the API

    ## Examples

    iex> HTTP.Api.get("https://jsonplaceholder.typicode.com/todos/1", [], [])

  """
  def get(url, headers \\ [], options \\ []) do
    url
    |> call(:get, "", headers, options)
    |> content_type
    |> decode
  end

  @doc """
  Send a HTTP request to the API using the HTTPoison Elixir library

    ## Examples

    iex> HTTPoison.request(:get, "https://jsonplaceholder.typicode.com/todos/1", "", [], [])
  """

  def call(url, method, body \\ "", headers \\ [], options \\ []) do
    HTTPoison.request(
      method,
      url,
      body,
      headers,
      options
    )
    |> case do
         {:ok, %{body: raw, status_code: code, headers: headers}} ->
           {code, raw, headers}

         {:error, %{reason: reason}} ->
           {:error, reason, []}
       end
  end

  @doc """
  Recursively check for "Content-Type" (& charset) in the list of headers
  Return "application/json" as the default if a "Content-Type" is not found

    ## Examples

    iex> HTTP.Api.content_type([{"Content-Type", "application/json; charset=utf-8"},{"Content-Length", "83"}])
    "application/json"
  """
  def content_type({code, raw_body, headers}), do: {code, raw_body, content_type(headers)}
  def content_type([]), do: "application/json"

  def content_type([{"Content-Type", c_type} | _]),
      do:
        c_type
        |> String.split(";")
        |> List.first()

  def content_type([_ | t]), do: content_type(t)

  @doc """
  Parse the body of a HTTP Response according to its type.
  """
  def decode({_code, :nxdomain, _c_type}), do: {:error, "service unavailable"}

  def decode({200, raw_body, "application/json"}) do
    raw_body
    |> Jason.decode(keys: :atoms)
    |> case do
         {:ok, body} -> {200, body}
         _ -> {:error, raw_body}
       end
  end
end
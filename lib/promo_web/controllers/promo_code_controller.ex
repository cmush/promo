defmodule PromoWeb.PromoCodeController do
  require Logger
  use PromoWeb, :controller

  alias Promo.{PromoCodes, EventLocations}
  alias Promo.{PromoCodes.PromoCode, EventLocations.EventLocation}

  action_fallback PromoWeb.FallbackController

  alias HttpClient.GmapsClient

  def index(conn, %{"validity" => "active"}) do
    promo_codes = PromoCodes.list_valid_promo_codes()
    render(conn, "index_with_event_location.json", promo_codes: promo_codes)
  end

  def index(conn, _params) do
    promo_codes = PromoCodes.list_promo_codes()
    render(conn, "index_with_event_location.json", promo_codes: promo_codes)
  end

  def create(conn, %{
        "promo_code" => %{"event_location" => event_location_params} = promo_code_params
      }) do
    case EventLocations.create_event_location(event_location_params) do
      {:ok, %EventLocation{} = event_location} ->
        # The location supplied is successfully created,
        # its id is then used to generate a promo code
        create_promo_code(conn, promo_code_params, event_location.id)

      _error ->
        # if an error occurs during event location creation,
        # it's probably because the place/venue already exists in event_locations
        # fetch the event_location and use its id to generate a new promo code
        with [%EventLocation{id: event_location_id}] <-
               EventLocations.get_event_location_by_place!(
                 Map.get(event_location_params, "place")
               ) do
          create_promo_code(conn, promo_code_params, event_location_id)
        end
    end
  end

  defp create_promo_code(conn, promo_code_params, event_location_id) do
    promo_code_params =
      promo_code_params
      |> upsert_p_code()
      |> Map.put("event_location_id", event_location_id)

    with {:ok, %PromoCode{} = promo_code} <-
           PromoCodes.create_promo_code(promo_code_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.promo_code_path(conn, :show, promo_code))
      |> render("show.json", promo_code: promo_code)
    end
  end

  # skip inserting a p_code if one has already been supplied in the request
  defp upsert_p_code(%{"p_code" => _p_code} = promo_code_params), do: promo_code_params
  # generate a p_code if its missing in the request
  defp upsert_p_code(%{} = promo_code_params),
    do:
      Map.put(
        promo_code_params,
        "p_code",
        # flawed: carries a small range of unique codes
        code_prefix() <> "-" <> random_string(5)
      )

  def random_string(length) do
    :crypto.strong_rand_bytes(length) |> Base.url_encode64() |> binary_part(0, length)
  end

  def code_prefix do
    # TODO: should be fetched from the db, should be configurable on admin dashboard
    "KaziSafe"
  end

  def show(conn, %{"id" => id}) do
    promo_code = PromoCodes.get_promo_code!(id)
    render(conn, "show.json", promo_code: promo_code)
  end

  def update(conn, %{"id" => id, "promo_code" => promo_code_params}) do
    promo_code = PromoCodes.get_promo_code!(id)

    with {:ok, %PromoCode{} = promo_code} <-
           PromoCodes.update_promo_code(promo_code, promo_code_params) do
      render(conn, "show.json", promo_code: promo_code)
    end
  end

  def delete(conn, %{"id" => id}) do
    promo_code = PromoCodes.get_promo_code!(id)

    with {:ok, %PromoCode{}} <- PromoCodes.delete_promo_code(promo_code) do
      send_resp(conn, :no_content, "")
    end
  end

  def deactivate(conn, %{"p_code" => p_code}) do
    [promo_code] = PromoCodes.get_promo_code_by_code!(p_code)
    PromoCodes.update_promo_code(%{promo_code | status: false}, %{})
    render(conn, "show.json", promo_code: promo_code)
  end

  def radius(conn, %{"p_code" => p_code, "promo_code" => %{"radius" => radius}}) do
    [promo_code] = PromoCodes.get_promo_code_by_code!(p_code)
    PromoCodes.update_promo_code(%{promo_code | radius: radius}, %{})
    render(conn, "show.json", promo_code: promo_code)
  end

  def check_validity(conn, request) do
    with(%PromoCode{} = promo_code <- check_validity(request)) do
      render(
        conn,
        "show.json",
        promo_code: promo_code
      )
    end
  end

  def check_validity(%{
        "p_code" => p_code,
        "origin" => %{
          "place" => ori_place,
          "latitude" => ori_latitude,
          "longitude" => ori_longitude
        },
        "destination" => %{
          "place" => dest_place,
          "latitude" => dest_latitude,
          "longitude" => dest_longitude
        }
      }) do
    # 1. begin by fetching the promo code
    with %PromoCode{} = promo_code <- PromoCodes.get_valid_promo_code_by_code!(p_code) do
      # 2. ensure that the validity check request fails if neither the origin nor
      #    the destination supplied for the journey equals the event_location
      #    associated to the promo_code
      # 3. fetch distance and polyline from the GMaps API

      promo_code
      # step 2
      |> origin_or_destination_equals_event(ori_place, dest_place)
      |> validate_within_allowed_radius(
        # origin coordinates
        ori_latitude <> "," <> ori_longitude,
        # destination coordinates
        dest_latitude <> "," <> dest_longitude
      )
    end
  end

  defp origin_or_destination_equals_event(
         %PromoCode{event_locations: event_locations} = promo_code,
         ori_place,
         dest_place
       ) do
    case ori_place == event_locations.place || dest_place == event_locations.place do
      false ->
        {:error, :origin_or_destination_not_equal_to_event}

      true ->
        promo_code
    end
  end

  @spec validate_within_allowed_radius(any, any, any) :: any
  def validate_within_allowed_radius(
        %PromoCode{radius: allowed_radius} = promo_code,
        origin,
        destination
      ) do
    %{
      "distance" => distance_to_destination,
      # overview polyline
      "polyline" => polyline
    } = get_distance_and_polyline(origin, destination)

    Logger.debug("distance_to_destination: #{inspect(distance_to_destination)}")
    Logger.debug("allowed_radius: #{inspect(allowed_radius)}")

    allowed = distance_to_destination > allowed_radius
    Logger.debug("distance_to_destination > allowed_radius?: #{inspect(allowed)}")

    if allowed do
      :distance_to_cover_exceeds_radius_allowed
    else
      Map.put(promo_code, :polyline, polyline)
    end
  end

  def validate_within_allowed_radius(state, _origin, _destination), do: state
  @spec get_distance_and_polyline(any, any) :: %{optional(<<_::64>>) => any}
  def get_distance_and_polyline(origin, destination) do
    resp = GmapsClient.fetch_directions(origin, destination)
    [routes] = resp.routes
    [legs] = routes.legs

    %{
      "distance" => meters_to_kilometers(legs.distance.value),
      "polyline" => routes.overview_polyline
    }
  end

  @spec meters_to_kilometers(number) :: float
  def meters_to_kilometers(distance_in_meters) do
    Float.round(distance_in_meters / 1000, 1)
  end
end

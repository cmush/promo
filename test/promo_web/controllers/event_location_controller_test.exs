defmodule PromoWeb.EventLocationControllerTest do
  use PromoWeb.ConnCase

  alias Promo.EventLocations
  alias Promo.EventLocations.EventLocation

  @create_attrs %{
    latitude: "some latitude",
    longitude: "some longitude",
    place: "some place"
  }
  @update_attrs %{
    latitude: "some updated latitude",
    longitude: "some updated longitude",
    place: "some updated place"
  }
  @invalid_attrs %{latitude: nil, longitude: nil, place: nil}

  def fixture(:event_location) do
    {:ok, event_location} = EventLocations.create_event_location(@create_attrs)
    event_location
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all event_locations", %{conn: conn} do
      conn = get(conn, Routes.event_location_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create event_location" do
    test "renders event_location when data is valid", %{conn: conn} do
      conn = post(conn, Routes.event_location_path(conn, :create), event_location: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.event_location_path(conn, :show, id))

      assert %{
               "id" => id,
               "latitude" => "some latitude",
               "longitude" => "some longitude",
               "place" => "some place"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.event_location_path(conn, :create), event_location: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update event_location" do
    setup [:create_event_location]

    test "renders event_location when data is valid", %{conn: conn, event_location: %EventLocation{id: id} = event_location} do
      conn = put(conn, Routes.event_location_path(conn, :update, event_location), event_location: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.event_location_path(conn, :show, id))

      assert %{
               "id" => id,
               "latitude" => "some updated latitude",
               "longitude" => "some updated longitude",
               "place" => "some updated place"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, event_location: event_location} do
      conn = put(conn, Routes.event_location_path(conn, :update, event_location), event_location: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete event_location" do
    setup [:create_event_location]

    test "deletes chosen event_location", %{conn: conn, event_location: event_location} do
      conn = delete(conn, Routes.event_location_path(conn, :delete, event_location))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.event_location_path(conn, :show, event_location))
      end
    end
  end

  defp create_event_location(_) do
    event_location = fixture(:event_location)
    {:ok, event_location: event_location}
  end
end

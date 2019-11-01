defmodule Promo.EventLocationsTest do
  use Promo.DataCase

  alias Promo.EventLocations

  describe "event_locations" do
    alias Promo.EventLocations.EventLocation

    @valid_attrs %{latitude: "some latitude", longitude: "some longitude", place: "some place"}
    @update_attrs %{
      latitude: "some updated latitude",
      longitude: "some updated longitude",
      place: "some updated place"
    }
    @invalid_attrs %{latitude: nil, longitude: nil, place: nil}

    def event_location_fixture(attrs \\ %{}) do
      {:ok, event_location} =
        attrs
        |> Enum.into(@valid_attrs)
        |> EventLocations.create_event_location()

      event_location
    end

    test "list_event_locations/0 returns all event_locations" do
      event_location = event_location_fixture()
      assert EventLocations.list_event_locations() == [event_location]
    end

    test "get_event_location!/1 returns the event_location with given id" do
      event_location = event_location_fixture()
      assert EventLocations.get_event_location!(event_location.id) == event_location
    end

    test "create_event_location/1 with valid data creates a event_location" do
      assert {:ok, %EventLocation{} = event_location} =
               EventLocations.create_event_location(@valid_attrs)

      assert event_location.latitude == "some latitude"
      assert event_location.longitude == "some longitude"
      assert event_location.place == "some place"
    end

    test "create_event_location/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = EventLocations.create_event_location(@invalid_attrs)
    end

    test "update_event_location/2 with valid data updates the event_location" do
      event_location = event_location_fixture()

      assert {:ok, %EventLocation{} = event_location} =
               EventLocations.update_event_location(event_location, @update_attrs)

      assert event_location.latitude == "some updated latitude"
      assert event_location.longitude == "some updated longitude"
      assert event_location.place == "some updated place"
    end

    test "update_event_location/2 with invalid data returns error changeset" do
      event_location = event_location_fixture()

      assert {:error, %Ecto.Changeset{}} =
               EventLocations.update_event_location(event_location, @invalid_attrs)

      assert event_location == EventLocations.get_event_location!(event_location.id)
    end

    test "delete_event_location/1 deletes the event_location" do
      event_location = event_location_fixture()
      assert {:ok, %EventLocation{}} = EventLocations.delete_event_location(event_location)

      assert_raise Ecto.NoResultsError, fn ->
        EventLocations.get_event_location!(event_location.id)
      end
    end

    test "change_event_location/1 returns a event_location changeset" do
      event_location = event_location_fixture()
      assert %Ecto.Changeset{} = EventLocations.change_event_location(event_location)
    end
  end
end

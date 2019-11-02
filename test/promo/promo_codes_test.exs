defmodule Promo.PromoCodesTest do
  use Promo.DataCase

  alias Promo.{PromoCodes, EventLocations}

  describe "promo_codes" do
    @valid_event_location %{
      latitude: "some latitude",
      longitude: "some longitude",
      place: "some place"
    }
    @update_event_location %{
      latitude: "some updated latitude",
      longitude: "some updated longitude",
      place: "some updated place"
    }

    def event_location_fixture(attrs \\ %{}) do
      {:ok, event_location} =
        attrs
        |> Enum.into(@valid_event_location)
        |> EventLocations.create_event_location()

      event_location
    end

    alias Promo.PromoCodes.PromoCode

    @valid_attrs %{
      amount: 120.5,
      expiry_date: Date.add(Date.utc_today(), 5),
      p_code: "some p_code",
      radius: 120.5,
      status: true,
      event_location_id: 0
    }
    @update_attrs %{
      amount: 456.7,
      expiry_date: Date.add(Date.utc_today(), -1),
      p_code: "some updated p_code",
      radius: 456.7,
      status: true,
      event_location_id: 0
    }
    @invalid_attrs %{
      amount: nil,
      expiry_date: nil,
      p_code: nil,
      radius: nil,
      status: nil,
      event_location_id: nil
    }

    def promo_code_fixture(attrs \\ %{}) do
      {:ok, promo_code} =
        attrs
        |> Enum.into(@valid_attrs)
        |> PromoCodes.create_promo_code()

      promo_code
    end

    test "list_promo_codes/0 returns all promo_codes" do
      event_location = event_location_fixture()
      promo_code = promo_code_fixture(%{@valid_attrs | event_location_id: event_location.id})
      # We need the promo codes to have the preloaded event_location
      promo_code = PromoCodes.get_promo_code_by_code!(promo_code.p_code)
      assert PromoCodes.list_promo_codes() == [promo_code]
    end

    test "list_valid_promo_codes/0 returns all valid promo_codes (active && not expired)" do
      event_location = event_location_fixture()
      promo_code = promo_code_fixture(%{@valid_attrs | event_location_id: event_location.id})
      # We need the promo codes to have the preloaded event_location
      promo_code = PromoCodes.get_promo_code_by_code!(promo_code.p_code)
      assert PromoCodes.list_valid_promo_codes() == [promo_code]
    end

    test "get_promo_code!/1 returns the promo_code with given id" do
      event_location = event_location_fixture()
      promo_code = promo_code_fixture(%{@valid_attrs | event_location_id: event_location.id})
      assert PromoCodes.get_promo_code!(promo_code.id) == promo_code
    end

    test "create_promo_code/1 with valid data creates a promo_code" do
      event_location = event_location_fixture()

      assert {:ok, %PromoCode{} = promo_code} =
               PromoCodes.create_promo_code(%{@valid_attrs | event_location_id: event_location.id})

      assert promo_code.amount == 120.5
      assert promo_code.expiry_date == Date.add(Date.utc_today(), 5)
      assert promo_code.p_code == "some p_code"
      assert promo_code.radius == 120.5
      assert promo_code.status == true
    end

    test "create_promo_code/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = PromoCodes.create_promo_code(@invalid_attrs)
    end

    test "update_promo_code/2 with valid data updates the promo_code" do
      event_location = event_location_fixture(@update_event_location)
      promo_code = promo_code_fixture(%{@valid_attrs | event_location_id: event_location.id})

      assert {:ok, %PromoCode{} = promo_code} =
               PromoCodes.update_promo_code(promo_code, %{
                 @update_attrs
                 | event_location_id: event_location.id
               })

      assert promo_code.amount == 456.7
      assert promo_code.expiry_date == Date.add(Date.utc_today(), -1)
      assert promo_code.p_code == "some updated p_code"
      assert promo_code.radius == 456.7
      assert promo_code.status == true
    end

    test "update_promo_code/2 with invalid data returns error changeset" do
      event_location = event_location_fixture()
      promo_code = promo_code_fixture(%{@valid_attrs | event_location_id: event_location.id})

      assert {:error, %Ecto.Changeset{}} =
               PromoCodes.update_promo_code(promo_code, @invalid_attrs)

      assert promo_code == PromoCodes.get_promo_code!(promo_code.id)
    end

    test "delete_promo_code/1 deletes the promo_code" do
      event_location = event_location_fixture()
      promo_code = promo_code_fixture(%{@valid_attrs | event_location_id: event_location.id})
      assert {:ok, %PromoCode{}} = PromoCodes.delete_promo_code(promo_code)
      assert_raise Ecto.NoResultsError, fn -> PromoCodes.get_promo_code!(promo_code.id) end
    end

    test "change_promo_code/1 returns a promo_code changeset" do
      event_location = event_location_fixture()
      promo_code = promo_code_fixture(%{@valid_attrs | event_location_id: event_location.id})
      assert %Ecto.Changeset{} = PromoCodes.change_promo_code(promo_code)
    end
  end
end

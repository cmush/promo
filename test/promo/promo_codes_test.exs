defmodule Promo.PromoCodesTest do
  use Promo.DataCase

  alias Promo.PromoCodes

  describe "promo_codes" do
    alias Promo.PromoCodes.PromoCode

    @valid_attrs %{expiry_date: ~D[2010-04-17], p_code: "some p_code", radius: 120.5, ride_amount: 120.5, status: true}
    @update_attrs %{expiry_date: ~D[2011-05-18], p_code: "some updated p_code", radius: 456.7, ride_amount: 456.7, status: false}
    @invalid_attrs %{expiry_date: nil, p_code: nil, radius: nil, ride_amount: nil, status: nil}

    def promo_code_fixture(attrs \\ %{}) do
      {:ok, promo_code} =
        attrs
        |> Enum.into(@valid_attrs)
        |> PromoCodes.create_promo_code()

      promo_code
    end

    test "list_promo_codes/0 returns all promo_codes" do
      promo_code = promo_code_fixture()
      assert PromoCodes.list_promo_codes() == [promo_code]
    end

    test "get_promo_code!/1 returns the promo_code with given id" do
      promo_code = promo_code_fixture()
      assert PromoCodes.get_promo_code!(promo_code.id) == promo_code
    end

    test "create_promo_code/1 with valid data creates a promo_code" do
      assert {:ok, %PromoCode{} = promo_code} = PromoCodes.create_promo_code(@valid_attrs)
      assert promo_code.expiry_date == ~D[2010-04-17]
      assert promo_code.p_code == "some p_code"
      assert promo_code.radius == 120.5
      assert promo_code.ride_amount == 120.5
      assert promo_code.status == true
    end

    test "create_promo_code/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = PromoCodes.create_promo_code(@invalid_attrs)
    end

    test "update_promo_code/2 with valid data updates the promo_code" do
      promo_code = promo_code_fixture()
      assert {:ok, %PromoCode{} = promo_code} = PromoCodes.update_promo_code(promo_code, @update_attrs)
      assert promo_code.expiry_date == ~D[2011-05-18]
      assert promo_code.p_code == "some updated p_code"
      assert promo_code.radius == 456.7
      assert promo_code.ride_amount == 456.7
      assert promo_code.status == false
    end

    test "update_promo_code/2 with invalid data returns error changeset" do
      promo_code = promo_code_fixture()
      assert {:error, %Ecto.Changeset{}} = PromoCodes.update_promo_code(promo_code, @invalid_attrs)
      assert promo_code == PromoCodes.get_promo_code!(promo_code.id)
    end

    test "delete_promo_code/1 deletes the promo_code" do
      promo_code = promo_code_fixture()
      assert {:ok, %PromoCode{}} = PromoCodes.delete_promo_code(promo_code)
      assert_raise Ecto.NoResultsError, fn -> PromoCodes.get_promo_code!(promo_code.id) end
    end

    test "change_promo_code/1 returns a promo_code changeset" do
      promo_code = promo_code_fixture()
      assert %Ecto.Changeset{} = PromoCodes.change_promo_code(promo_code)
    end
  end

  describe "promo_codes" do
    alias Promo.PromoCodes.PromoCode

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def promo_code_fixture(attrs \\ %{}) do
      {:ok, promo_code} =
        attrs
        |> Enum.into(@valid_attrs)
        |> PromoCodes.create_promo_code()

      promo_code
    end

    test "list_promo_codes/0 returns all promo_codes" do
      promo_code = promo_code_fixture()
      assert PromoCodes.list_promo_codes() == [promo_code]
    end

    test "get_promo_code!/1 returns the promo_code with given id" do
      promo_code = promo_code_fixture()
      assert PromoCodes.get_promo_code!(promo_code.id) == promo_code
    end

    test "create_promo_code/1 with valid data creates a promo_code" do
      assert {:ok, %PromoCode{} = promo_code} = PromoCodes.create_promo_code(@valid_attrs)
    end

    test "create_promo_code/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = PromoCodes.create_promo_code(@invalid_attrs)
    end

    test "update_promo_code/2 with valid data updates the promo_code" do
      promo_code = promo_code_fixture()
      assert {:ok, %PromoCode{} = promo_code} = PromoCodes.update_promo_code(promo_code, @update_attrs)
    end

    test "update_promo_code/2 with invalid data returns error changeset" do
      promo_code = promo_code_fixture()
      assert {:error, %Ecto.Changeset{}} = PromoCodes.update_promo_code(promo_code, @invalid_attrs)
      assert promo_code == PromoCodes.get_promo_code!(promo_code.id)
    end

    test "delete_promo_code/1 deletes the promo_code" do
      promo_code = promo_code_fixture()
      assert {:ok, %PromoCode{}} = PromoCodes.delete_promo_code(promo_code)
      assert_raise Ecto.NoResultsError, fn -> PromoCodes.get_promo_code!(promo_code.id) end
    end

    test "change_promo_code/1 returns a promo_code changeset" do
      promo_code = promo_code_fixture()
      assert %Ecto.Changeset{} = PromoCodes.change_promo_code(promo_code)
    end
  end
end

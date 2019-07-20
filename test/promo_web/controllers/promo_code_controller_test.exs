defmodule PromoWeb.PromoCodeControllerTest do
  use PromoWeb.ConnCase

  alias Promo.PromoCodes
  alias Promo.PromoCodes.PromoCode

  @create_attrs %{
    p_code: "SBPC_TEST_1",
    ride_amount: 200.00,
    expiry_date: Date.from_iso8601!("2019-08-19"),
    status: true,
    radius: 1.5
  }
  @update_attrs %{
    p_code: "SBPC_TEST_1_UPDATE",
    ride_amount: 300.00,
    expiry_date: Date.from_iso8601!("2019-09-19"),
    status: true,
    radius: 2.5
  }
  @invalid_attrs %{
    p_code: nil,
    ride_amount: nil,
    expiry_date: nil,
    status: nil,
    radius: nil
  }

  def fixture(:promo_code) do
    {:ok, promo_code} = PromoCodes.create_promo_code(@create_attrs)
    promo_code
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all promo_codes", %{conn: conn} do
      conn = get(conn, Routes.promo_code_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create promo_code" do
    test "renders promo_code when data is valid", %{conn: conn} do
      conn = post(conn, Routes.promo_code_path(conn, :create), promo_code: @create_attrs)

      assert %{
               "id" => id,
               "p_code" => p_code,
               "ride_amount" => ride_amount,
               "expiry_date" => expiry_date,
               "status" => status,
               "radius" => radius
             } = json_response(conn, 201)["data"]

      conn = get(conn, Routes.promo_code_path(conn, :show, id))

      assert %{
               "id" => id,
               "p_code" => p_code,
               "ride_amount" => ride_amount,
               "expiry_date" => expiry_date,
               "status" => status,
               "radius" => radius
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.promo_code_path(conn, :create), promo_code: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update promo_code" do
    setup [:create_promo_code]

    test "renders promo_code when data is valid", %{
      conn: conn,
      promo_code: %PromoCode{id: id} = promo_code
    } do
      conn =
        put(conn, Routes.promo_code_path(conn, :update, promo_code), promo_code: @update_attrs)

      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.promo_code_path(conn, :show, id))

      assert %{
               "id" => id
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, promo_code: promo_code} do
      conn =
        put(conn, Routes.promo_code_path(conn, :update, promo_code), promo_code: @invalid_attrs)

      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete promo_code" do
    setup [:create_promo_code]

    test "deletes chosen promo_code", %{conn: conn, promo_code: promo_code} do
      conn = delete(conn, Routes.promo_code_path(conn, :delete, promo_code))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.promo_code_path(conn, :show, promo_code))
      end
    end
  end

  defp create_promo_code(_) do
    promo_code = fixture(:promo_code)
    {:ok, promo_code: promo_code}
  end
end

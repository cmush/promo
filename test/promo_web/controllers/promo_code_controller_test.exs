defmodule PromoWeb.PromoCodeControllerTest do
  use PromoWeb.ConnCase

  alias Promo.PromoCodes
  alias Promo.PromoCodes.PromoCode

  @create_attrs %{
    amount: 120.5,
    expiry_date: ~D[2010-04-17],
    p_code: "some p_code",
    radius: 120.5,
    status: true
  }
  @update_attrs %{
    amount: 456.7,
    expiry_date: ~D[2011-05-18],
    p_code: "some updated p_code",
    radius: 456.7,
    status: false
  }
  @invalid_attrs %{amount: nil, expiry_date: nil, p_code: nil, radius: nil, status: nil}

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
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.promo_code_path(conn, :show, id))

      assert %{
               "id" => id,
               "amount" => 120.5,
               "expiry_date" => "2010-04-17",
               "p_code" => "some p_code",
               "radius" => 120.5,
               "status" => true
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.promo_code_path(conn, :create), promo_code: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update promo_code" do
    setup [:create_promo_code]

    test "renders promo_code when data is valid", %{conn: conn, promo_code: %PromoCode{id: id} = promo_code} do
      conn = put(conn, Routes.promo_code_path(conn, :update, promo_code), promo_code: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.promo_code_path(conn, :show, id))

      assert %{
               "id" => id,
               "amount" => 456.7,
               "expiry_date" => "2011-05-18",
               "p_code" => "some updated p_code",
               "radius" => 456.7,
               "status" => false
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, promo_code: promo_code} do
      conn = put(conn, Routes.promo_code_path(conn, :update, promo_code), promo_code: @invalid_attrs)
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

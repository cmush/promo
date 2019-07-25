defmodule PromoWeb.PromoCodeControllerTest do
  use PromoWeb.ConnCase

  alias Promo.PromoCodes
  alias Promo.PromoCodes.PromoCode

  @valid__create_attrs %{
    p_code: "SBPC_TEST_1",
    ride_amount: 200.00,
    # set to 2 days from now since it's always expected to be valid
    expiry_date: Date.to_string(Date.add(Date.utc_today(), 2)),
    status: true,
    radius: 3
  }
  @invalid__td_exceeds_ra %{
    p_code: "SBPC_TEST_2",
    ride_amount: 200.00,
    expiry_date: Date.from_iso8601!("2019-08-19"),
    status: true,
    radius: 1.5
  }
  @update_attrs %{
    p_code: "SBPC_TEST_1_UPDATE",
    ride_amount: 300.00,
    expiry_date: Date.from_iso8601!("2019-09-19"),
    status: false,
    radius: 2.5
  }
  @invalid_attrs %{
    p_code: nil,
    ride_amount: nil,
    expiry_date: nil,
    status: nil,
    radius: nil
  }
  @validate_attrs__valid %{
    p_code: "SBPC_TEST_1",
    origin: %{
      place: "Nairobi, Westlands",
      latitude: "-1.269650",
      longitude: "36.808922"
    },
    destination: %{
      place: "Nairobi, Upperhill",
      latitude: "-1.285790",
      longitude: "36.820030"
    }
  }
  @validate_attrs__invalid_distance %{
    p_code: "SBPC_TEST_2",
    origin: %{
      place: "Nairobi, Westlands",
      latitude: "-1.269650",
      longitude: "36.808922"
    },
    destination: %{
      place: "Nairobi, Upperhill",
      latitude: "-1.285790",
      longitude: "36.820030"
    }
  }

  def fixture(:promo_code) do
    {:ok, promo_code} = PromoCodes.create_promo_code(@valid__create_attrs)
    promo_code
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "list all promo codes" do
    test "lists all promo_codes", %{conn: conn} do
      conn =
        conn
        |> get(Routes.promo_code_path(conn, :index))
        |> doc(
          description: "list all promo codes regardless of state",
          operation_id: "index"
        )

      assert json_response(conn, 200)["data"] == []
    end

    test "lists all active (true) promo_codes", %{conn: conn} do
      conn =
        conn
        |> get(
          Routes.promo_code_path(conn, :show_where_status, true),
          # promo_code status = true
          promo_code: @valid__create_attrs
        )
        |> doc(
          description: "lists all active (true) promo_codes",
          operation_id: "show_where_status"
        )

      assert json_response(conn, 200)["data"] == []
    end

    test "lists all inactive (false) promo_codes", %{conn: conn} do
      conn =
        conn
        |> get(
          Routes.promo_code_path(conn, :show_where_status, false),
          # promo_code status = false
          promo_code: @update_attrs
        )
        |> doc(
          description: "lists all inactive (false) promo_codes",
          operation_id: "show_where_status"
        )

      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create promo_code" do
    test "renders promo_code when data is valid", %{conn: conn} do
      conn_create =
        conn
        |> post(Routes.promo_code_path(conn, :create), promo_code: @valid__create_attrs)
        |> doc(
          description: "create promo_code",
          operation_id: "create"
        )

      assert %{
               "id" => id,
               "p_code" => p_code,
               "ride_amount" => ride_amount,
               "expiry_date" => expiry_date,
               "status" => status,
               "radius" => radius
             } = json_response(conn_create, 201)["data"]

      conn_show =
        conn
        |> get(Routes.promo_code_path(conn, :show, id))
        |> doc(
          description: "show promo_code",
          operation_id: "show"
        )

      assert %{
               "id" => id,
               "p_code" => p_code,
               "ride_amount" => ride_amount,
               "expiry_date" => expiry_date,
               "status" => status,
               "radius" => radius
             } = json_response(conn_show, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn =
        conn
        |> post(Routes.promo_code_path(conn, :create), promo_code: @invalid_attrs)
        |> doc(
          description: "invalid promo_code request (blank fields)",
          operation_id: "create"
        )

      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update promo_code" do
    setup [:create_promo_code]

    test "renders promo_code when data is valid", %{
      conn: conn,
      promo_code: %PromoCode{id: id} = promo_code
    } do
      conn_update =
        conn
        |> put(Routes.promo_code_path(conn, :update, promo_code), promo_code: @update_attrs)
        |> doc(
          description: "update promo_code details",
          operation_id: "update"
        )

      assert %{"id" => ^id} = json_response(conn_update, 200)["data"]

      conn = get(conn, Routes.promo_code_path(conn, :show, id))

      assert %{
               "id" => id
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, promo_code: promo_code} do
      conn_update =
        conn
        |> put(Routes.promo_code_path(conn, :update, promo_code), promo_code: @invalid_attrs)
        |> doc(
          description: "attempt to update promo_code with invalid details",
          operation_id: "update"
        )

      assert json_response(conn_update, 422)["errors"] != %{}
    end
  end

  describe "delete promo_code" do
    setup [:create_promo_code]

    test "deletes chosen promo_code", %{conn: conn, promo_code: promo_code} do
      conn =
        conn
        |> delete(Routes.promo_code_path(conn, :delete, promo_code))
        |> doc(
          description: "delete promo_code ",
          operation_id: "delete"
        )

      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.promo_code_path(conn, :show, promo_code))
      end
    end
  end

  describe "validate promo code" do
    test "scenario 1 - promo code valid for this scenario", %{conn: conn} do
      post(conn, Routes.promo_code_path(conn, :create), promo_code: @valid__create_attrs)

      conn =
        conn
        |> post(Routes.promo_code_path(conn, :validate), @validate_attrs__valid)
        |> doc(
          description: "validate promo_code scenario 1 - promo code valid",
          operation_id: "validate"
        )

      assert %{
               "id" => id,
               "p_code" => p_code,
               "ride_amount" => ride_amount,
               "expiry_date" => expiry_date,
               "status" => status,
               "radius" => radius
             } = json_response(conn, 200)["data"]
    end

    test "scenario 2 - travel_distance_exceeds_radius_allowed", %{conn: conn} do
      post(conn, Routes.promo_code_path(conn, :create), promo_code: @invalid__td_exceeds_ra)

      conn =
        conn
        |> post(Routes.promo_code_path(conn, :validate), @validate_attrs__invalid_distance)
        |> doc(
          description: "validate promo_code scenario 2 - travel_distance_exceeds_radius_allowed",
          operation_id: "validate"
        )

      assert "promo_code_invalid__travel_distance_exceeds_radius_allowed" =
               json_response(conn, 203)["error"]
    end
  end

  defp create_promo_code(_) do
    promo_code = fixture(:promo_code)
    {:ok, promo_code: promo_code}
  end
end

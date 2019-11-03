defmodule PromoWeb.PromoCodeControllerTest do
  use PromoWeb.ConnCase

  alias Promo.EventLocations

  @event_location %{
    place: "Nairobi, Ngong Racecourse",
    longitude: "36.73916371",
    latitude: "-1.30583211"
  }

  @pre_update_event_location %{
    latitude: "-1.285790",
    longitude: "36.820030",
    place: "Nairobi, Upperhill"
  }

  @updated_event_location %{
    latitude: "-1.2982",
    longitude: "36.7624",
    place: "Nairobi, The Junction Mall"
  }

  @origin_location %{
    latitude: "-1.269650",
    longitude: "36.808922",
    place: "Nairobi, Westlands"
  }

  @destination_location %{
    place: "Nairobi, Ngong Racecourse",
    longitude: "36.73916371",
    latitude: "-1.30583211"
  }

  alias Promo.PromoCodes
  alias Promo.PromoCodes.PromoCode

  @create_attrs %{
    amount: 120.5,
    expiry_date: Date.add(Date.utc_today(), 5),
    p_code: "some p_code",
    radius: 120.5,
    status: true,
    event_location_id: 0,
    event_location: @event_location
  }
  @update_attrs %{
    amount: 456.7,
    expiry_date: Date.add(Date.utc_today(), -1),
    p_code: "some updated p_code",
    radius: 456.7,
    status: false,
    event_location_id: 0,
    event_location: @pre_update_event_location
  }
  @invalid_attrs %{
    amount: nil,
    expiry_date: nil,
    p_code: nil,
    radius: nil,
    status: nil,
    event_location_id: nil,
    event_location: %{
      latitude: nil,
      longitude: nil,
      place: nil
    }
  }

  def fixture(:promo_code) do
    # event_location_fixture
    {:ok, event_location} = EventLocations.create_event_location(@event_location)

    {:ok, promo_code} =
      PromoCodes.create_promo_code(%{@create_attrs | event_location_id: event_location.id})

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

    test "lists all valid promo_codes (promo codes where validity == active)", %{conn: conn} do
      conn = get(conn, Routes.promo_code_path(conn, :index, validity: "active"))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create promo_code" do
    test "renders promo_code when data is valid", %{conn: conn} do
      conn = post(conn, Routes.promo_code_path(conn, :create), promo_code: @create_attrs)

      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.promo_code_path(conn, :show, id))

      assert %{
               # TODO: verify actual values
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
      {:ok, event_location} = EventLocations.create_event_location(@updated_event_location)

      conn =
        put(conn, Routes.promo_code_path(conn, :update, promo_code),
          promo_code: %{@update_attrs | event_location_id: event_location.id}
        )

      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.promo_code_path(conn, :show, id))

      assert %{
               # TODO: verify actual values
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

  describe "promo_code operations" do
    setup [:create_promo_code]

    test "check validity of supplied promo_code (active && yet to expire)", %{
      conn: conn,
      promo_code: promo_code
    } do
      %PromoCode{p_code: p_code} = PromoCodes.get_promo_code_by_code!(promo_code.p_code)

      conn =
        post(
          conn,
          Routes.promo_code_path(conn, :check_validity, p_code,
            origin: @origin_location,
            destination: @destination_location
          )
        )

      assert %{
               # TODO: verify actual values
             } = json_response(conn, 200)["data"]
    end

    #    test "configure a promo_code's radius"
    #    test "deactivate a promo_code"
  end

  defp create_promo_code(_) do
    promo_code = fixture(:promo_code)
    {:ok, promo_code: promo_code}
  end
end

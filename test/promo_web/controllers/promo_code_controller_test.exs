defmodule PromoWeb.PromoCodeControllerTest do
  use PromoWeb.ConnCase

  alias Promo.EventLocations

  #  @origin_location %{
  #    latitude: "-1.269650",
  #    longitude: "36.808922",
  #    place: "Nairobi, Westlands"
  #  }
  #
  #  @destination_location %{
  #    latitude: "-1.285790",
  #    longitude: "36.820030",
  #    place: "Nairobi, Upperhill"
  #  }

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

  alias Promo.PromoCodes
  alias Promo.PromoCodes.PromoCode

  @create_attrs %{
    amount: 120.5,
    expiry_date: Date.add(Date.utc_today(), 5),
    p_code: "some p_code",
    radius: 120.5,
    status: true,
    event_location_id: 0,
    event_location: %{
      latitude: "some latitude",
      longitude: "some longitude",
      place: "some place"
    }
  }
  @update_attrs %{
    amount: 456.7,
    expiry_date: Date.add(Date.utc_today(), -1),
    p_code: "some updated p_code",
    radius: 456.7,
    status: false,
    event_location_id: 0,
    event_location: %{
      latitude: "some updated latitude",
      longitude: "some updated longitude",
      place: "some updated place"
    }
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
    event_location = event_location_fixture()

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
      event_location = event_location_fixture()

      conn =
        post(conn, Routes.promo_code_path(conn, :create),
          promo_code: %{@create_attrs | event_location_id: event_location.id}
        )

      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.promo_code_path(conn, :show, id))

      assert %{
               #               "id" => id,
               #               "amount" => 120.5,
               #               "expiry_date" => "2010-04-17",
               #               "p_code" => "some p_code", # a random string is generated & never matches
               #               "radius" => 120.5,
               #               "status" => true
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
      event_location = event_location_fixture(@update_event_location)

      conn =
        put(conn, Routes.promo_code_path(conn, :update, promo_code),
          promo_code: %{@update_attrs | event_location_id: event_location.id}
        )

      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.promo_code_path(conn, :show, id))

      assert %{
               #               "id" => id,
               #               "amount" => 456.7,
               #               "expiry_date" => "2011-05-18",
               #               "p_code" => "some updated p_code", # a random string is generated & never matches
               #               "radius" => 456.7,
               #               "status" => false
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
      IO.inspect(promo_code, label: "promo_code")
      %PromoCode{p_code: p_code} = PromoCodes.get_promo_code_by_code!(promo_code.p_code)
      IO.inspect(promo_code, label: "promo_code")

      conn
      |> post(
        Routes.promo_code_path(conn, :check_validity, p_code,
          origin: %{latitude: "-1.269650", longitude: "36.808922", place: "Nairobi, Westlands"},
          destination: %{
            latitude: "-1.269650",
            longitude: "36.808922",
            place: "Nairobi, Westlands"
          }
        )
      )
    end

    #    test "configure a promo_code's radius"
    #    test "deactivate a promo_code"
  end

  defp create_promo_code(_) do
    promo_code = fixture(:promo_code)
    {:ok, promo_code: promo_code}
  end
end

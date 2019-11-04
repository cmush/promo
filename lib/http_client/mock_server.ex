defmodule HttpClient.MockServer do
  @moduledoc """
  Intended to provide a mock for the GMaps Api that's not tightly coupled to the HttpClient.
  - The benefit here is that, say the client implementation/ a dependency
    needs to change, the Mock will remain unaffected.
  """
  use Plug.Router

  plug Plug.Parsers,
    parsers: [:json],
    pass: ["text/*"],
    json_decoder: Poison

  plug :match
  plug :dispatch

  # Sample request
  # base url: https://maps.googleapis.com/maps/api/directions/
  # the request: json?destination=-1.285790,36.820030&key=AIzaSyCamumc0jF8YfoxCU8qwfcwpS6_7b0IgPM&origin=-1.269650,36.808922&
  @escaped_json_response ~S"""
  { "geocoded_waypoints" : [ { "geocoder_status" : "OK", "place_id" : "ChIJ_fBv2DsXLxgRYb95JLwEsNQ", "types" : [ "street_address" ] }, { "geocoder_status" : "OK", "place_id" : "ChIJ37THLtcQLxgR4CPUaOkugbU", "types" : [ "establishment", "point_of_interest", "travel_agency" ] } ], "routes" : [ { "bounds" : { "northeast" : { "lat" : -1.2696464, "lng" : 36.8197769 }, "southwest" : { "lat" : -1.2863518, "lng" : 36.8079146 } }, "copyrights" : "Map data ©2019", "legs" : [ { "distance" : { "text" : "2.6 km", "value" : 2637 }, "duration" : { "text" : "7 mins", "value" : 409 }, "end_address" : "Caxton House, 3rd Floor Koinange St, Nairobi, Kenya", "end_location" : { "lat" : -1.2859304, "lng" : 36.8197769 }, "start_address" : "43 Westlands Rd, Nairobi, Kenya", "start_location" : { "lat" : -1.2696464, "lng" : 36.8089257 }, "steps" : [ { "distance" : { "text" : "45 m", "value" : 45 }, "duration" : { "text" : "1 min", "value" : 9 }, "end_location" : { "lat" : -1.269935, "lng" : 36.8092035 }, "html_instructions" : "Head \u003cb\u003esoutheast\u003c/b\u003e on \u003cb\u003eWestlands Rd\u003c/b\u003e toward \u003cb\u003eChiromo Ln\u003c/b\u003e", "polyline" : { "points" : "h~vFyft_Fx@u@" }, "start_location" : { "lat" : -1.2696464, "lng" : 36.8089257 }, "travel_mode" : "DRIVING" }, { "distance" : { "text" : "0.2 km", "value" : 191 }, "duration" : { "text" : "1 min", "value" : 68 }, "end_location" : { "lat" : -1.271066, "lng" : 36.8079146 }, "html_instructions" : "Turn \u003cb\u003eright\u003c/b\u003e at Mc frys-adams arcade onto \u003cb\u003eChiromo Ln\u003c/b\u003e", "maneuver" : "turn-right", "polyline" : { "points" : "b`wFoht_FjArAFHdApAVXVZVZ" }, "start_location" : { "lat" : -1.269935, "lng" : 36.8092035 }, "travel_mode" : "DRIVING" }, { "distance" : { "text" : "1.5 km", "value" : 1473 }, "duration" : { "text" : "2 mins", "value" : 148 }, "end_location" : { "lat" : -1.2815088, "lng" : 36.8150508 }, "html_instructions" : "Turn \u003cb\u003eleft\u003c/b\u003e at NealcorpKE onto \u003cb\u003eChiromo Rd\u003c/b\u003e/\u003cwbr/\u003e\u003cb\u003eWaiyaki Way\u003c/b\u003e/\u003cwbr/\u003e\u003cb\u003eA104\u003c/b\u003e\u003cdiv style=\"font-size:0.9em\"\u003eContinue to follow A104\u003c/div\u003e\u003cdiv style=\"font-size:0.9em\"\u003ePass by Outresources HR Consulting (on the left)\u003c/div\u003e", "maneuver" : "turn-left", "polyline" : { "points" : "dgwFm`t_FVW@?XWVUBAXU?AZWLILKDCRQHGDGHGXWBCTUFGNQVY?AVYT[HIJSFMHODMHQP_@JSDIHQ@ADKP]N_@P_@BELYP]LUR]@CPYBCRUFIPOVYXYd@c@b@_@d@[FEVOx@g@`Am@^O^O^QFCVI^OLERE`@IB?^GD?\\E`@EDA\\E`@E@?`@Cb@ELATCb@CRANC`@ED?\\Eb@E^EB?`@GDAVEb@KrA[lAe@jAg@TKTQ" }, "start_location" : { "lat" : -1.271066, "lng" : 36.8079146 }, "travel_mode" : "DRIVING" }, { "distance" : { "text" : "0.6 km", "value" : 600 }, "duration" : { "text" : "2 mins", "value" : 108 }, "end_location" : { "lat" : -1.2862914, "lng" : 36.8173657 }, "html_instructions" : "At the roundabout, take the \u003cb\u003e2nd\u003c/b\u003e exit onto \u003cb\u003eUhuru Hwy\u003c/b\u003e/\u003cwbr/\u003e\u003cb\u003eA104\u003c/b\u003e\u003cdiv style=\"font-size:0.9em\"\u003ePass by Soft law (on the left)\u003c/div\u003e", "maneuver" : "roundabout-left", "polyline" : { "points" : "lhyFamu_F@C?A@C@A?A@A@C@ABABABABABAD?BAB@H?@@@?@@@?@@@@@?@@RGJENEj@Sn@WpAa@bA_@\\OPInBw@tF{BdBs@h@UZQNM" }, "start_location" : { "lat" : -1.2815088, "lng" : 36.8150508 }, "travel_mode" : "DRIVING" }, { "distance" : { "text" : "0.3 km", "value" : 263 }, "duration" : { "text" : "1 min", "value" : 53 }, "end_location" : { "lat" : -1.2854125, "lng" : 36.819498 }, "html_instructions" : "At the roundabout, take the \u003cb\u003e1st\u003c/b\u003e exit onto \u003cb\u003eKenyatta Ave\u003c/b\u003e\u003cdiv style=\"font-size:0.9em\"\u003ePass by GPO (on the right)\u003c/div\u003e", "maneuver" : "roundabout-left", "polyline" : { "points" : "hfzFq{u_F?E@E@C@E@CBEE]GUIQM]_@_AM]Sg@sA_D" }, "start_location" : { "lat" : -1.2862914, "lng" : 36.8173657 }, "travel_mode" : "DRIVING" }, { "distance" : { "text" : "65 m", "value" : 65 }, "duration" : { "text" : "1 min", "value" : 23 }, "end_location" : { "lat" : -1.2859304, "lng" : 36.8197769 }, "html_instructions" : "Turn \u003cb\u003eright\u003c/b\u003e at City Clock onto \u003cb\u003eKoinange St\u003c/b\u003e\u003cdiv style=\"font-size:0.9em\"\u003ePass by Nairobi (on the left)\u003c/div\u003e\u003cdiv style=\"font-size:0.9em\"\u003eDestination will be on the left\u003c/div\u003e", "maneuver" : "turn-right", "polyline" : { "points" : "x`zF{hv_FNGXMBARKJERIDC" }, "start_location" : { "lat" : -1.2854125, "lng" : 36.819498 }, "travel_mode" : "DRIVING" } ], "traffic_speed_entry" : [], "via_waypoint" : [] } ], "overview_polyline" : { "points" : "h~vFyft_Fx@u@jArAlAzAn@t@VZVWZWVUx@q@hB{Ap@s@dAqAf@{@l@sAnAmC`AkBj@w@jAmAhAcAl@a@pAw@`Am@^O~@a@^Ml@Ut@OfAM|D_@fE_@jAOz@QrA[lAe@`Bs@VUBIHINGV?FBFDzAg@`Cy@`Bo@|MqFdAg@NMDUDIE]_AeCa@eAsA_DNG\\O^QXM" }, "summary" : "A104", "warnings" : [], "waypoint_order" : [] } ], "status" : "OK" }
  """
  get "/json" do
    case conn.params do
      %{
        "destination" => "-1.285790,36.820030",
        "key" => "gmaps_api_key",
        "origin" => "-1.269650,36.808922"
      } ->
        conn
        |> put_resp_header("Content-Type", "application/json")
        |> send_resp(200, @escaped_json_response)

      _error ->
        send_resp(conn, 400, "destination, key or origin is missing from request")
    end
  end
end

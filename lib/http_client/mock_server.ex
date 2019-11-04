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
  # the request: json?destination=-1.30583211,36.73916371&key=AIzaSyCamumc0jF8YfoxCU8qwfcwpS6_7b0IgPM&origin=-1.269650,36.808922&
  @escaped_json_response ~S"""
  { "geocoded_waypoints" : [ { "geocoder_status" : "OK", "place_id" : "ChIJ_fBv2DsXLxgRYb95JLwEsNQ", "types" : [ "street_address" ] }, { "geocoder_status" : "OK", "place_id" : "ChIJCdZLKFMaLxgR8KPSwpv4lLg", "types" : [ "route" ] } ], "routes" : [ { "bounds" : { "northeast" : { "lat" : -1.258953, "lng" : 36.8092686 }, "southwest" : { "lat" : -1.3063579, "lng" : 36.7392285 } }, "copyrights" : "Map data ©2019", "legs" : [ { "distance" : { "text" : "12.9 km", "value" : 12877 }, "duration" : { "text" : "26 mins", "value" : 1588 }, "end_address" : "Ngong Rd, Nairobi, Kenya", "end_location" : { "lat" : -1.3061666, "lng" : 36.7392285 }, "start_address" : "43 Westlands Rd, Nairobi, Kenya", "start_location" : { "lat" : -1.2696464, "lng" : 36.8089257 }, "steps" : [ { "distance" : { "text" : "45 m", "value" : 45 }, "duration" : { "text" : "1 min", "value" : 9 }, "end_location" : { "lat" : -1.269935, "lng" : 36.8092035 }, "html_instructions" : "Head \u003cb\u003esoutheast\u003c/b\u003e on \u003cb\u003eWestlands Rd\u003c/b\u003e toward \u003cb\u003eChiromo Ln\u003c/b\u003e", "polyline" : { "points" : "h~vFyft_Fx@u@" }, "start_location" : { "lat" : -1.2696464, "lng" : 36.8089257 }, "travel_mode" : "DRIVING" }, { "distance" : { "text" : "0.2 km", "value" : 191 }, "duration" : { "text" : "1 min", "value" : 68 }, "end_location" : { "lat" : -1.271066, "lng" : 36.8079146 }, "html_instructions" : "Turn \u003cb\u003eright\u003c/b\u003e at the 1st cross street onto \u003cb\u003eChiromo Ln\u003c/b\u003e", "maneuver" : "turn-right", "polyline" : { "points" : "b`wFoht_FjArAFHdApAVXVZVZ" }, "start_location" : { "lat" : -1.269935, "lng" : 36.8092035 }, "travel_mode" : "DRIVING" }, { "distance" : { "text" : "0.1 km", "value" : 123 }, "duration" : { "text" : "1 min", "value" : 16 }, "end_location" : { "lat" : -1.2719052, "lng" : 36.8086394 }, "html_instructions" : "Turn \u003cb\u003eleft\u003c/b\u003e onto \u003cb\u003eChiromo Rd\u003c/b\u003e/\u003cwbr/\u003e\u003cb\u003eWaiyaki Way\u003c/b\u003e/\u003cwbr/\u003e\u003cb\u003eA104\u003c/b\u003e", "maneuver" : "turn-left", "polyline" : { "points" : "dgwFm`t_FVW@?XWVUBAXU?AZWLILKDC" }, "start_location" : { "lat" : -1.271066, "lng" : 36.8079146 }, "travel_mode" : "DRIVING" }, { "distance" : { "text" : "0.1 km", "value" : 137 }, "duration" : { "text" : "1 min", "value" : 22 }, "end_location" : { "lat" : -1.2728738, "lng" : 36.8091978 }, "html_instructions" : "Slight \u003cb\u003eright\u003c/b\u003e toward \u003cb\u003eChiromo Rd\u003c/b\u003e/\u003cwbr/\u003e\u003cb\u003eWaiyaki Way\u003c/b\u003e/\u003cwbr/\u003e\u003cb\u003eA104\u003c/b\u003e", "maneuver" : "turn-slight-right", "polyline" : { "points" : "llwF_et_F@@B?@?@?B?JGHGHGHGXUHIZ]XYDE@?@AB?@?D@B@RH" }, "start_location" : { "lat" : -1.2719052, "lng" : 36.8086394 }, "travel_mode" : "DRIVING" }, { "distance" : { "text" : "4.3 km", "value" : 4308 }, "duration" : { "text" : "7 mins", "value" : 403 }, "end_location" : { "lat" : -1.2594186, "lng" : 36.7757846 }, "html_instructions" : "Turn \u003cb\u003eright\u003c/b\u003e onto \u003cb\u003eChiromo Rd\u003c/b\u003e/\u003cwbr/\u003e\u003cb\u003eWaiyaki Way\u003c/b\u003e/\u003cwbr/\u003e\u003cb\u003eA104\u003c/b\u003e\u003cdiv style=\"font-size:0.9em\"\u003ePass by the gas station (on the left in 3.2 km)\u003c/div\u003e", "maneuver" : "turn-right", "polyline" : { "points" : "lrwFoht_FCDU\\c@h@}@|@oAhAWTA@iA~@eAv@u@p@MLKHKNMHSPEDMHOHKHOJ]RYVCBWRYV[VURCB[VURCB[RA@GDYVEBKHEBKHMLKJMJEBSTkBzAw@p@u@n@uBfBqB`BWTwBbBSRMRCHELCJCFCDSVA@C@C@C@KBGBI@SDC@[FSDOFQFWPSNKJOJ_@\\eA|@WRwAjAi@j@[\\U^QXQ`@M\\[`A[nAGVQx@Oh@SrA?@Gb@E`@?@OtBATCb@?@E`@Cb@Eb@Cb@CPANATALCb@Cb@Cb@AL?TCb@Ab@Ab@Ab@Ab@?b@Ab@Ct@Ep@CTIn@OfAUdA[`BA@Eb@ADKv@OnAOlAGt@InA[xHKxAGzAAb@ItA?RUpDIrAQjCMrBm@xKWfDGhACf@Cr@CxA?n@@Z@t@Fz@H`AVxC\\fDNnA@`@" }, "start_location" : { "lat" : -1.2728738, "lng" : 36.8091978 }, "travel_mode" : "DRIVING" }, { "distance" : { "text" : "4.2 km", "value" : 4181 }, "duration" : { "text" : "8 mins", "value" : 484 }, "end_location" : { "lat" : -1.2896021, "lng" : 36.7616381 }, "html_instructions" : "Turn \u003cb\u003eleft\u003c/b\u003e onto \u003cb\u003eJames Gichuru Road\u003c/b\u003e\u003cdiv style=\"font-size:0.9em\"\u003ePass by St Austin's Academy (on the left in 2.4 km)\u003c/div\u003e", "maneuver" : "turn-left", "polyline" : { "points" : "j~tFswm_FHBDBDBD@D?J@NAbBQb@CNAR??A@?X@F@J@RDB@PFLFBBPJDDHFLR@@LPBF@@NZ@??@P^JTDHP^HNFNN^@@^v@L\\R\\R`@Xb@Z`@RRXXZPZN^NVFLBVDH@VD`@B\\?RARCPEPEXIREnAg@r@c@NKd@Yj@a@bBcAj@]DAd@[r@_@v@e@~@g@b@Wl@_@^OXKb@MLCVE@?\\GXCh@CVAPAV?L@R?l@@D?b@D^BB?bAHr@HD?b@HJBJBTF`@JD@ZJXJD@PHLDLFPH@?ZPDBVPHDPNZVZTPNHFXTZV@?XTZTBBVRZTZTZVZTZVBBTPZTZV\\NLDNH@?HFLFDBVNDBDBJDLD@?@A@?@?@?@?@?@?@?@@@?@?@@@?@@@@@?@@?@@@?@@@@@?B?@?@@@?@?@A@?B?@NLNNHH@@HHJLBBRTLL@?JHJFBBJFPHr@^dBv@x@^|Av@TJv@^JFfAh@B@^R\\RJF\\R\\R\\RHFB@LHzA~@ZT\\TVX@?RTBDTXBDZb@HL^f@d@p@f@p@BDNRRZLPDHDDRVRZDFTZDFTZTZLPFHJNHLTZLPFHR\\`@j@f@t@VZt@dAHJ~@dAZXVT@@ZXFFRNZVDDRNBBJJf@b@f@XJFZR^Pf@VVHLFnBr@JDB@NBxAV`BTj@Fl@HVBd@BT@@?D@N@f@B^?" }, "start_location" : { "lat" : -1.2594186, "lng" : 36.7757846 }, "travel_mode" : "DRIVING" }, { "distance" : { "text" : "1.1 km", "value" : 1079 }, "duration" : { "text" : "3 mins", "value" : 166 }, "end_location" : { "lat" : -1.298923, "lng" : 36.7618338 }, "html_instructions" : "Continue onto \u003cb\u003eKingara Rd\u003c/b\u003e\u003cdiv style=\"font-size:0.9em\"\u003ePass by Mulberry Apartments (on the left)\u003c/div\u003e", "polyline" : { "points" : "~zzFg_k_FX?v@@F?n@@dAB^@R?N@b@@b@@b@?b@@b@@b@@b@@b@@b@@V?J?V?J?\\@D?b@?N@R?\\?D?^AB?b@?R?N?H@V?@?b@@X?H?H@J?R@B?Z@\\?b@@H?V@f@?`@?b@@jB@x@?n@BbA@hC@\\?dABBOHc@Ha@BK" }, "start_location" : { "lat" : -1.2896021, "lng" : 36.7616381 }, "travel_mode" : "DRIVING" }, { "distance" : { "text" : "51 m", "value" : 51 }, "duration" : { "text" : "1 min", "value" : 10 }, "end_location" : { "lat" : -1.2990141, "lng" : 36.7622819 }, "html_instructions" : "Continue onto \u003cb\u003eNgong Rd\u003c/b\u003e", "polyline" : { "points" : "fu|Fm`k_FDYDa@D]" }, "start_location" : { "lat" : -1.298923, "lng" : 36.7618338 }, "travel_mode" : "DRIVING" }, { "distance" : { "text" : "25 m", "value" : 25 }, "duration" : { "text" : "1 min", "value" : 10 }, "end_location" : { "lat" : -1.2992013, "lng" : 36.7623029 }, "html_instructions" : "Turn \u003cb\u003eright\u003c/b\u003e toward \u003cb\u003eNgong Rd\u003c/b\u003e", "maneuver" : "turn-right", "polyline" : { "points" : "xu|Fgck_FBE@A@A@A@?BAB?B@LF" }, "start_location" : { "lat" : -1.2990141, "lng" : 36.7622819 }, "travel_mode" : "DRIVING" }, { "distance" : { "text" : "0.2 km", "value" : 169 }, "duration" : { "text" : "1 min", "value" : 33 }, "end_location" : { "lat" : -1.2992703, "lng" : 36.7608194 }, "html_instructions" : "Turn \u003cb\u003eright\u003c/b\u003e onto \u003cb\u003eNgong Rd\u003c/b\u003e", "maneuver" : "turn-right", "polyline" : { "points" : "~v|Fkck_FLj@@L?JAFEPIz@ATC^?DBTBPBNHV" }, "start_location" : { "lat" : -1.2992013, "lng" : 36.7623029 }, "travel_mode" : "DRIVING" }, { "distance" : { "text" : "2.5 km", "value" : 2496 }, "duration" : { "text" : "5 mins", "value" : 326 }, "end_location" : { "lat" : -1.3063579, "lng" : 36.73960580000001 }, "html_instructions" : "Continue onto \u003cb\u003eNgong Rd\u003c/b\u003e\u003cdiv style=\"font-size:0.9em\"\u003ePass by Kenya Meteorological Dept Headquarters (on the left)\u003c/div\u003e", "polyline" : { "points" : "lw|Fczj_F\\fANn@BR?N?HADADGF?LBFHV`@xAPr@J^Tz@Rn@V~@Jb@Nd@Lf@J^DNp@bCXhARt@Tx@HZXfAZhAV`ATz@Tv@HZFTBFNj@Rv@FRT|@HZNl@V|@?BV|@|AzF\\xANh@\\vAhAlEFRtAfF^|Ab@`B@DBH`@zAPn@^tA^vARp@Jb@BH^vAJ^DPDPDPDRBP@BBTBPBLHt@D`@R`BTfBHr@l@`F" }, "start_location" : { "lat" : -1.2992703, "lng" : 36.7608194 }, "travel_mode" : "DRIVING" }, { "distance" : { "text" : "29 m", "value" : 29 }, "duration" : { "text" : "1 min", "value" : 29 }, "end_location" : { "lat" : -1.3060936, "lng" : 36.73960539999999 }, "html_instructions" : "Turn \u003cb\u003eright\u003c/b\u003e", "maneuver" : "turn-right", "polyline" : { "points" : "vc~Fquf_Fu@?" }, "start_location" : { "lat" : -1.3063579, "lng" : 36.73960580000001 }, "travel_mode" : "DRIVING" }, { "distance" : { "text" : "43 m", "value" : 43 }, "duration" : { "text" : "1 min", "value" : 12 }, "end_location" : { "lat" : -1.3061666, "lng" : 36.7392285 }, "html_instructions" : "Turn \u003cb\u003eleft\u003c/b\u003e\u003cdiv style=\"font-size:0.9em\"\u003eDestination will be on the right\u003c/div\u003e", "maneuver" : "turn-left", "polyline" : { "points" : "`b~Fquf_FNjA" }, "start_location" : { "lat" : -1.3060936, "lng" : 36.73960539999999 }, "travel_mode" : "DRIVING" } ], "traffic_speed_entry" : [], "via_waypoint" : [] } ], "overview_polyline" : { "points" : "h~vFyft_Fx@u@jArAlAzAn@t@VZVWZWVUx@q@ZUFAJ?h@_@xAwALG^LYb@aBfBsD`DeAv@u@p@YVs@p@y@h@{@n@}CjCcBnAm@h@mFrEgFhEoCxBa@f@CHQf@]\\WH}@Pc@Li@XoAdA}ApAwAjAi@j@q@|@c@z@i@~Ac@fBa@bBStAMdAOvBK|A[tEIjBGjBEnCIfBMdAcApFc@pDWbCe@hKStDKxBq@dL{@lO_@pFGzAChCBpAP|Bt@`IPpBZLP@rBSfAGn@DVF^Nd@\\`@n@hA~Bb@`Al@tAf@~@t@dAl@l@v@`@v@VfAP~@Bf@EpA[nAg@r@c@t@e@nCeBp@_@pEiCpAw@x@[jAWv@K`AEjA?vBJ`CRpAX|Ad@r@Xt@^`DbCfDfCvAhAp@f@ZV\\N\\NJFp@^`@NFANBJJDPADNNd@d@p@t@\\TvDhBdFbCvBfAdBbAx@f@vBtA\\Tp@t@~@pAhD|EzB|CjBnCvCbEhApAr@n@x@r@x@p@r@n@r@`@zBfAlCbAhBZlC\\dALz@D~@FbHHjGLrDDrD?dHJdCBdD@rBDfD@dABBOReAHe@J_ADGHEF@LFLj@@XGXOvBFf@Lf@l@vBBb@ANILBTj@pBfA~D~CnLnG~UhFdSrGtV`DtLVhAL|@f@fE^zCl@`Fu@?NjA" }, "summary" : "A104 and James Gichuru Road", "warnings" : [], "waypoint_order" : [] } ], "status" : "OK" }
  """
  get "/destination/json" do
    case conn.params do
      %{
        "destination" => "-1.30583211,36.73916371",
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

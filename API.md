# API Documentation

  * [API /promo_codes](#api-promo_codes)
    * [index](#api-promo_codes-index)
    * [create](#api-promo_codes-create)
    * [show](#api-promo_codes-show)
    * [create](#api-promo_codes-create)
    * [update](#api-promo_codes-update)
    * [delete](#api-promo_codes-delete)
    * [check_validity](#api-promo_codes-check_validity)
    * [radius](#api-promo_codes-radius)
    * [deactivate](#api-promo_codes-deactivate)

## API /promo_codes
### <a id=api-promo_codes-index></a>index
#### list all promo codes regardless of state
##### Request
* __Method:__ GET
* __Path:__ /api/promo_codes
* __Request headers:__
```
accept: application/json
```

##### Response
* __Status__: 200
* __Response headers:__
```
content-type: application/json; charset=utf-8
cache-control: max-age=0, private, must-revalidate
x-request-id: FdOtW5OijUBTJSgAAAQh
```
* __Response body:__
```json
{
  "data": [
    {
      "status": true,
      "radius": 120.5,
      "p_code": "some p_code",
      "id": 1716,
      "expiry_date": "2019-11-08",
      "event_location": {
        "place": "Nairobi, Ngong Racecourse",
        "longitude": "36.73916371",
        "latitude": "-1.30583211"
      },
      "amount": 120.5
    }
  ]
}
```

#### lists all valid promo_codes (promo codes where validity == active)
##### Request
* __Method:__ GET
* __Path:__ /api/promo_codes?validity=active
* __Request headers:__
```
accept: application/json
```

##### Response
* __Status__: 200
* __Response headers:__
```
content-type: application/json; charset=utf-8
cache-control: max-age=0, private, must-revalidate
x-request-id: FdOtW5bz3wgYT4QAAAUh
```
* __Response body:__
```json
{
  "data": [
    {
      "status": true,
      "radius": 120.5,
      "p_code": "some p_code",
      "id": 1720,
      "expiry_date": "2019-11-08",
      "event_location": {
        "place": "Nairobi, Ngong Racecourse",
        "longitude": "36.73916371",
        "latitude": "-1.30583211"
      },
      "amount": 120.5
    }
  ]
}
```

### <a id=api-promo_codes-create></a>create
#### renders promo_code when data is valid
##### Request
* __Method:__ POST
* __Path:__ /api/promo_codes
* __Request headers:__
```
accept: application/json
content-type: multipart/mixed; boundary=plug_conn_test
```
* __Request body:__
```json
{
  "promo_code": {
    "status": true,
    "radius": 120.5,
    "p_code": "some p_code",
    "expiry_date": "2019-11-08",
    "event_location_id": 0,
    "event_location": {
      "place": "Nairobi, Ngong Racecourse",
      "longitude": "36.73916371",
      "latitude": "-1.30583211"
    },
    "amount": 120.5
  }
}
```

##### Response
* __Status__: 201
* __Response headers:__
```
content-type: application/json; charset=utf-8
cache-control: max-age=0, private, must-revalidate
x-request-id: FdOtW5G1hmgY_AIAAAOh
location: /api/promo_codes/1714
```
* __Response body:__
```json
{
  "data": {
    "status": true,
    "radius": 120.5,
    "p_code": "some p_code",
    "id": 1714,
    "expiry_date": "2019-11-08",
    "event_location_id": 3474,
    "amount": 120.5
  }
}
```

### <a id=api-promo_codes-show></a>show
#### retrieve a single promo_code by id
##### Request
* __Method:__ GET
* __Path:__ /api/promo_codes/1714
* __Request headers:__
```
accept: application/json
```

##### Response
* __Status__: 200
* __Response headers:__
```
content-type: application/json; charset=utf-8
cache-control: max-age=0, private, must-revalidate
x-request-id: FdOtW5JHoMAY_AIAAAPB
```
* __Response body:__
```json
{
  "data": {
    "status": true,
    "radius": 120.5,
    "p_code": "some p_code",
    "id": 1714,
    "expiry_date": "2019-11-08",
    "event_location_id": 3474,
    "amount": 120.5
  }
}
```

### <a id=api-promo_codes-create></a>create
#### renders errors when data is invalid
##### Request
* __Method:__ POST
* __Path:__ /api/promo_codes
* __Request headers:__
```
accept: application/json
content-type: multipart/mixed; boundary=plug_conn_test
```
* __Request body:__
```json
{
  "promo_code": {
    "status": null,
    "radius": null,
    "p_code": null,
    "expiry_date": null,
    "event_location_id": null,
    "event_location": {
      "place": null,
      "longitude": null,
      "latitude": null
    },
    "amount": null
  }
}
```

##### Response
* __Status__: 422
* __Response headers:__
```
content-type: application/json; charset=utf-8
cache-control: max-age=0, private, must-revalidate
x-request-id: FdOtW5T2fLB5Z1EAAATB
```
* __Response body:__
```json
{
  "errors": {
    "detail": "Unprocessable Entity"
  }
}
```

### <a id=api-promo_codes-update></a>update
#### renders promo_code when data is valid
##### Request
* __Method:__ PUT
* __Path:__ /api/promo_codes/1718
* __Request headers:__
```
accept: application/json
content-type: multipart/mixed; boundary=plug_conn_test
```
* __Request body:__
```json
{
  "promo_code": {
    "status": false,
    "radius": 456.7,
    "p_code": "some updated p_code",
    "expiry_date": "2019-11-02",
    "event_location_id": 3479,
    "event_location": {
      "place": "Nairobi, Upperhill",
      "longitude": "36.820030",
      "latitude": "-1.285790"
    },
    "amount": 456.7
  }
}
```

##### Response
* __Status__: 200
* __Response headers:__
```
content-type: application/json; charset=utf-8
cache-control: max-age=0, private, must-revalidate
x-request-id: FdOtW5Sz-VjA6_AAAASB
```
* __Response body:__
```json
{
  "data": {
    "status": false,
    "radius": 456.7,
    "p_code": "some updated p_code",
    "id": 1718,
    "expiry_date": "2019-11-02",
    "event_location_id": 3479,
    "amount": 456.7
  }
}
```

#### renders errors when data is invalid
##### Request
* __Method:__ PUT
* __Path:__ /api/promo_codes/1715
* __Request headers:__
```
accept: application/json
content-type: multipart/mixed; boundary=plug_conn_test
```
* __Request body:__
```json
{
  "promo_code": {
    "status": null,
    "radius": null,
    "p_code": null,
    "expiry_date": null,
    "event_location_id": null,
    "event_location": {
      "place": null,
      "longitude": null,
      "latitude": null
    },
    "amount": null
  }
}
```

##### Response
* __Status__: 422
* __Response headers:__
```
content-type: application/json; charset=utf-8
cache-control: max-age=0, private, must-revalidate
x-request-id: FdOtW5KxxKDbnp0AAAQB
```
* __Response body:__
```json
{
  "errors": {
    "status": [
      "can't be blank"
    ],
    "radius": [
      "can't be blank"
    ],
    "p_code": [
      "can't be blank"
    ],
    "expiry_date": [
      "can't be blank"
    ],
    "event_location_id": [
      "can't be blank"
    ],
    "amount": [
      "can't be blank"
    ]
  }
}
```

### <a id=api-promo_codes-delete></a>delete
#### deletes chosen promo_code
##### Request
* __Method:__ DELETE
* __Path:__ /api/promo_codes/1719
* __Request headers:__
```
accept: application/json
```

##### Response
* __Status__: 204
* __Response headers:__
```
cache-control: max-age=0, private, must-revalidate
x-request-id: FdOtW5VGzzBI8acAAATh
```
* __Response body:__
```json

```

### <a id=api-promo_codes-check_validity></a>check_validity
#### check validity of supplied promo_code (active && yet to expire)
##### Request
* __Method:__ POST
* __Path:__ /api/promo_codes/check_validity/some%20p_code?origin[latitude]=-1.269650&origin[longitude]=36.808922&origin[place]=Nairobi%2C+Westlands&destination[latitude]=-1.30583211&destination[longitude]=36.73916371&destination[place]=Nairobi%2C+Ngong+Racecourse
* __Request headers:__
```
accept: application/json
```

##### Response
* __Status__: 200
* __Response headers:__
```
content-type: application/json; charset=utf-8
cache-control: max-age=0, private, must-revalidate
x-request-id: FdOtW2zR2GDAhjcAAANh
```
* __Response body:__
```json
{
  "data": {
    "status": true,
    "radius": 120.5,
    "polyline": {
      "points": "h~vFyft_Fx@u@jArAlAzAn@t@VZVWZWVUx@q@ZUFAJ?h@_@xAwALG^LYb@aBfBsD`DeAv@u@p@YVs@p@y@h@{@n@}CjCcBnAm@h@mFrEgFhEoCxBa@f@CHQf@]\\WH}@Pc@Li@XoAdA}ApAwAjAi@j@q@|@c@z@i@~Ac@fBa@bBStAMdAOvBK|A[tEIjBGjBEnCIfBMdAcApFc@pDWbCe@hKStDKxBq@dL{@lO_@pFGzAChCBpAP|Bt@`IPpBZLP@rBSfAGn@DVF^Nd@\\`@n@hA~Bb@`Al@tAf@~@t@dAl@l@v@`@v@VfAP~@Bf@EpA[nAg@r@c@t@e@nCeBp@_@pEiCpAw@x@[jAWv@K`AEjA?vBJ`CRpAX|Ad@r@Xt@^`DbCfDfCvAhAp@f@ZV\\N\\NJFp@^`@NFANBJJDPADNNd@d@p@t@\\TvDhBdFbCvBfAdBbAx@f@vBtA\\Tp@t@~@pAhD|EzB|CjBnCvCbEhApAr@n@x@r@x@p@r@n@r@`@zBfAlCbAhBZlC\\dALz@D~@FbHHjGLrDDrD?dHJdCBdD@rBDfD@dABBOReAHe@J_ADGHEF@LFLj@@XGXOvBFf@Lf@l@vBBb@ANILBTj@pBfA~D~CnLnG~UhFdSrGtV`DtLVhAL|@f@fE^zCl@`Fu@?NjA"
    },
    "p_code": "some p_code",
    "id": 1713,
    "expiry_date": "2019-11-08",
    "event_location": {
      "place": "Nairobi, Ngong Racecourse",
      "longitude": "36.73916371",
      "latitude": "-1.30583211"
    },
    "distance_to_destination": 12.9,
    "amount": 120.5
  }
}
```

### <a id=api-promo_codes-radius></a>radius
#### configure a promo_code's radius
##### Request
* __Method:__ POST
* __Path:__ /api/promo_codes/radius/some%20p_code?promo_code[radius]=2.5
* __Request headers:__
```
accept: application/json
```

##### Response
* __Status__: 200
* __Response headers:__
```
content-type: application/json; charset=utf-8
cache-control: max-age=0, private, must-revalidate
x-request-id: FdOtW5Qe1agldnQAAARh
```
* __Response body:__
```json
{
  "data": {
    "status": true,
    "radius": 120.5,
    "p_code": "some p_code",
    "id": 1717,
    "expiry_date": "2019-11-08",
    "event_location_id": 3477,
    "amount": 120.5
  }
}
```

### <a id=api-promo_codes-deactivate></a>deactivate
#### deactivate a promo_code
##### Request
* __Method:__ POST
* __Path:__ /api/promo_codes/deactivate/some%20p_code
* __Request headers:__
```
accept: application/json
```

##### Response
* __Status__: 200
* __Response headers:__
```
content-type: application/json; charset=utf-8
cache-control: max-age=0, private, must-revalidate
x-request-id: FdOtW2ns_DiYj7oAAADE
```
* __Response body:__
```json
{
  "data": {
    "status": true,
    "radius": 120.5,
    "p_code": "some p_code",
    "id": 1712,
    "expiry_date": "2019-11-08",
    "event_location_id": 3472,
    "amount": 120.5
  }
}
```


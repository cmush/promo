# API Documentation

  * [API /promo_codes](#api-promo_codes)
    * [index](#api-promo_codes-index)
    * [show_where_status](#api-promo_codes-show_where_status)
    * [create](#api-promo_codes-create)
    * [show](#api-promo_codes-show)
    * [create](#api-promo_codes-create)
    * [update](#api-promo_codes-update)
    * [delete](#api-promo_codes-delete)
    * [validate](#api-promo_codes-validate)

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
x-request-id: FbSpqjmVugjA6_AAAAJD
```
* __Response body:__
```json
{
  "data": []
}
```

### <a id=api-promo_codes-show_where_status></a>show_where_status
#### lists all active (true) promo_codes
##### Request
* __Method:__ GET
* __Path:__ /api/promo_codes/status/true
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
    "ride_amount": 200.0,
    "radius": 3,
    "p_code": "SBPC_TEST_1",
    "expiry_date": "2019-07-27"
  }
}
```

##### Response
* __Status__: 200
* __Response headers:__
```
content-type: application/json; charset=utf-8
cache-control: max-age=0, private, must-revalidate
x-request-id: FbSpqmiulLie4UsAAALj
```
* __Response body:__
```json
{
  "data": []
}
```

#### lists all inactive (false) promo_codes
##### Request
* __Method:__ GET
* __Path:__ /api/promo_codes/status/false
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
    "ride_amount": 300.0,
    "radius": 2.5,
    "p_code": "SBPC_TEST_1_UPDATE",
    "expiry_date": "2019-09-19"
  }
}
```

##### Response
* __Status__: 200
* __Response headers:__
```
content-type: application/json; charset=utf-8
cache-control: max-age=0, private, must-revalidate
x-request-id: FbSpqneC-6Cis5UAAAOD
```
* __Response body:__
```json
{
  "data": []
}
```

### <a id=api-promo_codes-create></a>create
#### create promo_code
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
    "ride_amount": 200.0,
    "radius": 3,
    "p_code": "SBPC_TEST_1",
    "expiry_date": "2019-07-27"
  }
}
```

##### Response
* __Status__: 201
* __Response headers:__
```
content-type: application/json; charset=utf-8
cache-control: max-age=0, private, must-revalidate
x-request-id: FbSpqjk60JgldnQAAADi
location: /api/promo_codes/1346
```
* __Response body:__
```json
{
  "data": {
    "status": true,
    "ride_amount": 200.0,
    "radius": 3.0,
    "p_code": "SBPC_TEST_1",
    "id": 1346,
    "expiry_date": "2019-07-27"
  }
}
```

### <a id=api-promo_codes-show></a>show
#### show promo_code
##### Request
* __Method:__ GET
* __Path:__ /api/promo_codes/1346
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
x-request-id: FbSpqjlnGIgldnQAAAEC
```
* __Response body:__
```json
{
  "data": {
    "status": true,
    "ride_amount": 200.0,
    "radius": 3.0,
    "p_code": "SBPC_TEST_1",
    "id": 1346,
    "expiry_date": "2019-07-27"
  }
}
```

### <a id=api-promo_codes-create></a>create
#### invalid promo_code request (blank fields)
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
    "ride_amount": null,
    "radius": null,
    "p_code": null,
    "expiry_date": null
  }
}
```

##### Response
* __Status__: 422
* __Response headers:__
```
content-type: application/json; charset=utf-8
cache-control: max-age=0, private, must-revalidate
x-request-id: FbSpqmltulDOZEcAAAKE
```
* __Response body:__
```json
{
  "errors": {
    "status": [
      "can't be blank"
    ],
    "ride_amount": [
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
    ]
  }
}
```

### <a id=api-promo_codes-update></a>update
#### update promo_code details
##### Request
* __Method:__ PUT
* __Path:__ /api/promo_codes/1348
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
    "ride_amount": 300.0,
    "radius": 2.5,
    "p_code": "SBPC_TEST_1_UPDATE",
    "expiry_date": "2019-09-19"
  }
}
```

##### Response
* __Status__: 200
* __Response headers:__
```
content-type: application/json; charset=utf-8
cache-control: max-age=0, private, must-revalidate
x-request-id: FbSpqmkXtsgQlCgAAAMj
```
* __Response body:__
```json
{
  "data": {
    "status": false,
    "ride_amount": 300.0,
    "radius": 2.5,
    "p_code": "SBPC_TEST_1_UPDATE",
    "id": 1348,
    "expiry_date": "2019-09-19"
  }
}
```

#### attempt to update promo_code with invalid details
##### Request
* __Method:__ PUT
* __Path:__ /api/promo_codes/1345
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
    "ride_amount": null,
    "radius": null,
    "p_code": null,
    "expiry_date": null
  }
}
```

##### Response
* __Status__: 422
* __Response headers:__
```
content-type: application/json; charset=utf-8
cache-control: max-age=0, private, must-revalidate
x-request-id: FbSpqjS_uFhTJSgAAAID
```
* __Response body:__
```json
{
  "errors": {
    "status": [
      "can't be blank"
    ],
    "ride_amount": [
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
    ]
  }
}
```

### <a id=api-promo_codes-delete></a>delete
#### delete promo_code 
##### Request
* __Method:__ DELETE
* __Path:__ /api/promo_codes/1350
* __Request headers:__
```
accept: application/json
```

##### Response
* __Status__: 204
* __Response headers:__
```
cache-control: max-age=0, private, must-revalidate
x-request-id: FbSpqnf32ZgSUqUAAAOj
```
* __Response body:__
```json

```

### <a id=api-promo_codes-validate></a>validate
#### validate promo_code scenario 1 - promo code valid
##### Request
* __Method:__ POST
* __Path:__ /api/promo_codes/validate
* __Request headers:__
```
accept: application/json
content-type: multipart/mixed; boundary=plug_conn_test
```
* __Request body:__
```json
{
  "p_code": "SBPC_TEST_1",
  "origin": {
    "place": "Nairobi, Westlands",
    "longitude": "36.808922",
    "latitude": "-1.269650"
  },
  "destination": {
    "place": "Nairobi, Upperhill",
    "longitude": "36.820030",
    "latitude": "-1.285790"
  }
}
```

##### Response
* __Status__: 200
* __Response headers:__
```
content-type: application/json; charset=utf-8
cache-control: max-age=0, private, must-revalidate
x-request-id: FbSpqmmye-BV3_oAAANj
```
* __Response body:__
```json
{
  "data": {
    "status": true,
    "ride_amount": 200.0,
    "radius": 3.0,
    "polyline": {
      "points": "h~vFyft_Fx@u@jArAlAzAn@t@VZVWZWVUx@q@hB{Ap@s@dAqAf@{@l@sA|AgDt@uAp@}@hBgBhA{@xA}@`Am@^O~@a@lAc@xAWjAMnE_@pD]bB[rA[lAe@`Bs@VU@EDILGPEPBFDB@^M|DsAbFqBzIoDdAg@NM@KHSE]Qg@oAcDsA_DNG\\Ox@_@"
    },
    "p_code": "SBPC_TEST_1",
    "id": 1349,
    "expiry_date": "2019-07-27"
  }
}
```

#### validate promo_code scenario 2 - travel_distance_exceeds_radius_allowed
##### Request
* __Method:__ POST
* __Path:__ /api/promo_codes/validate
* __Request headers:__
```
accept: application/json
content-type: multipart/mixed; boundary=plug_conn_test
```
* __Request body:__
```json
{
  "p_code": "SBPC_TEST_2",
  "origin": {
    "place": "Nairobi, Westlands",
    "longitude": "36.808922",
    "latitude": "-1.269650"
  },
  "destination": {
    "place": "Nairobi, Upperhill",
    "longitude": "36.820030",
    "latitude": "-1.285790"
  }
}
```

##### Response
* __Status__: 203
* __Response headers:__
```
content-type: application/json; charset=utf-8
cache-control: max-age=0, private, must-revalidate
x-request-id: FbSpqjoIgNh5Z1EAAAKj
```
* __Response body:__
```json
{
  "error": "promo_code_invalid__travel_distance_exceeds_radius_allowed"
}
```


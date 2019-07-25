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
x-request-id: FbSpc46yPoDA6_AAAAJi
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
x-request-id: FbSpc4sEm-hTJSgAAAGk
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
x-request-id: FbSpc4561ugldnQAAAHk
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
x-request-id: FbSpc48GIxB5Z1EAAAKi
location: /api/promo_codes/1331
```
* __Response body:__
```json
{
  "data": {
    "status": true,
    "ride_amount": 200.0,
    "radius": 3.0,
    "p_code": "SBPC_TEST_1",
    "id": 1331,
    "expiry_date": "2019-07-27"
  }
}
```

### <a id=api-promo_codes-show></a>show
#### show promo_code
##### Request
* __Method:__ GET
* __Path:__ /api/promo_codes/1331
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
x-request-id: FbSpc5DigEh5Z1EAAADD
```
* __Response body:__
```json
{
  "data": {
    "status": true,
    "ride_amount": 200.0,
    "radius": 3.0,
    "p_code": "SBPC_TEST_1",
    "id": 1331,
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
x-request-id: FbSpc8P5W8jOZEcAAAED
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
* __Path:__ /api/promo_codes/1333
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
x-request-id: FbSpc8Oo1oAQlCgAAAJk
```
* __Response body:__
```json
{
  "data": {
    "status": false,
    "ride_amount": 300.0,
    "radius": 2.5,
    "p_code": "SBPC_TEST_1_UPDATE",
    "id": 1333,
    "expiry_date": "2019-09-19"
  }
}
```

#### attempt to update promo_code with invalid details
##### Request
* __Method:__ PUT
* __Path:__ /api/promo_codes/1334
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
x-request-id: FbSpc8TJ2shV3_oAAAKk
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
* __Path:__ /api/promo_codes/1335
* __Request headers:__
```
accept: application/json
```

##### Response
* __Status__: 204
* __Response headers:__
```
cache-control: max-age=0, private, must-revalidate
x-request-id: FbSpc8UuTaCis5UAAALC
```
* __Response body:__
```json

```

### <a id=api-promo_codes-validate></a>validate
#### validate promo_code scenario 1 - travel_distance_exceeds_radius_allowed
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
x-request-id: FbSpc5FhObBI8acAAAIk
```
* __Response body:__
```json
{
  "error": "promo_code_invalid__travel_distance_exceeds_radius_allowed"
}
```


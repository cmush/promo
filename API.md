# API Documentation

  * [API /promo_codes](#api-promo_codes)
    * [index](#api-promo_codes-index)
    * [show_where_status](#api-promo_codes-show_where_status)
    * [create](#api-promo_codes-create)
    * [show](#api-promo_codes-show)
    * [create](#api-promo_codes-create)

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
x-request-id: FbShI67WprgSPmoAAAwE
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
    "radius": 1.5,
    "p_code": "SBPC_TEST_1",
    "expiry_date": "2019-08-19"
  }
}
```

##### Response
* __Status__: 200
* __Response headers:__
```
content-type: application/json; charset=utf-8
cache-control: max-age=0, private, must-revalidate
x-request-id: FbShI6-C9BjckTMAAAxk
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
x-request-id: FbShI6znu4Amr1IAABHD
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
    "radius": 1.5,
    "p_code": "SBPC_TEST_1",
    "expiry_date": "2019-08-19"
  }
}
```

##### Response
* __Status__: 201
* __Response headers:__
```
content-type: application/json; charset=utf-8
cache-control: max-age=0, private, must-revalidate
x-request-id: FbShI6-8V4B0rPYAABID
location: /api/promo_codes/865
```
* __Response body:__
```json
{
  "data": {
    "status": true,
    "ride_amount": 200.0,
    "radius": 1.5,
    "p_code": "SBPC_TEST_1",
    "id": 865,
    "expiry_date": "2019-08-19"
  }
}
```

### <a id=api-promo_codes-show></a>show
#### show promo_code
##### Request
* __Method:__ GET
* __Path:__ /api/promo_codes/865
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
x-request-id: FbShI7DGtuh0rPYAABIj
```
* __Response body:__
```json
{
  "data": {
    "status": true,
    "ride_amount": 200.0,
    "radius": 1.5,
    "p_code": "SBPC_TEST_1",
    "id": 865,
    "expiry_date": "2019-08-19"
  }
}
```

### <a id=api-promo_codes-create></a>create
#### invalid promo_code
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
x-request-id: FbShI68TG0iK9E8AAAxE
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


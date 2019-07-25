# API Documentation

  * [API /promo_codes](#api-promo_codes)
    * [index](#api-promo_codes-index)
    * [show_where_status](#api-promo_codes-show_where_status)

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
x-request-id: FbSYE36RUogtaSkAAAHi
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
x-request-id: FbSYE36tbdljPzMAAANj
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
x-request-id: FbSYE37a2sPHtsQAAAOD
```
* __Response body:__
```json
{
  "data": []
}
```


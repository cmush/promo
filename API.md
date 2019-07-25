# API Documentation

  * [API /promo_codes](#api-promo_codes)
    * [index](#api-promo_codes-index)
    * [show_where_status](#api-promo_codes-show_where_status)
    * [create](#api-promo_codes-create)
    * [show](#api-promo_codes-show)
    * [create](#api-promo_codes-create)
    * [update](#api-promo_codes-update)
    * [delete](#api-promo_codes-delete)

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
x-request-id: FbSiC9RwGAbA6_AAAANC
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
x-request-id: FbSiC9Z7i9gQlCgAAAPC
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
x-request-id: FbSiC9Vh0sxI8acAAAOC
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
x-request-id: FbSiC9WiNykYT4QAAADD
location: /api/promo_codes/932
```
* __Response body:__
```json
{
  "data": {
    "status": true,
    "ride_amount": 200.0,
    "radius": 1.5,
    "p_code": "SBPC_TEST_1",
    "id": 932,
    "expiry_date": "2019-08-19"
  }
}
```

### <a id=api-promo_codes-show></a>show
#### show promo_code
##### Request
* __Method:__ GET
* __Path:__ /api/promo_codes/932
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
x-request-id: FbSiC9XYx-cYT4QAAAHk
```
* __Response body:__
```json
{
  "data": {
    "status": true,
    "ride_amount": 200.0,
    "radius": 1.5,
    "p_code": "SBPC_TEST_1",
    "id": 932,
    "expiry_date": "2019-08-19"
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
x-request-id: FbSiC9SyaJN5Z1EAAADh
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
* __Path:__ /api/promo_codes/930
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
x-request-id: FbSiC86jpL5TJSgAAAKi
```
* __Response body:__
```json
{
  "data": {
    "status": false,
    "ride_amount": 300.0,
    "radius": 2.5,
    "p_code": "SBPC_TEST_1_UPDATE",
    "id": 930,
    "expiry_date": "2019-09-19"
  }
}
```

#### attempt to update promo_code with invalid details
##### Request
* __Method:__ PUT
* __Path:__ /api/promo_codes/933
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
x-request-id: FbSiC9ZN_7Ke4UsAAAIE
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
* __Path:__ /api/promo_codes/931
* __Request headers:__
```
accept: application/json
```

##### Response
* __Status__: 204
* __Response headers:__
```
cache-control: max-age=0, private, must-revalidate
x-request-id: FbSiC9JqQbUldnQAAAMC
```
* __Response body:__
```json

```


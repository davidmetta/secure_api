# ROUTES

Those are the routes available SecureApi:

#### NOTE
If you have customized the `email` and `password` fields, you should keep the same ones when making the requests.

## Login

```curl
curl -X POST 'https://MY_OWN_DOMAIN/user/login' \
  -H 'Content-Type: application/json' \
  -d '{
    "email": "name@example.com",
    "password": "123456"
  }'
```

### HTTP Request
`POST /user/login`

### Request Body
Field | Type | required | Default | Description
----- | ---- | -------- | ------- | -----------
email | String | true | | email of the user
password | String | true | | password of the user

### Response Status
200

## Logout

```curl
curl -X DELETE 'https://MY_OWN_DOMAIN/user/logout' \
  -H 'Content-Type: application/json'
  -H 'Authorization: TOKEN'
```

### HTTP Request
`DELETE /user/logout`

### Response Status
200

## Check Token

```curl
curl -X GET 'https://MY_OWN_DOMAIN/user/check_token?access_token=TOKEN' \
  -H 'Content-Type: application/json'
```

### HTTP Request
`GET /user/check_token`

### Request Parameters
Parameter | Type | required | Default | Description
--------- | ---- | -------- | ------- | -----------
access_token | String | true | | the Auth token

### Response Status
200

# Promo

An elixir/phoenix micro service for management of promotional codes for issuing
free rides on a ride sharing platform.

Promo uses the Google Maps API to calculate distances and fetch directions between
the specified origin and destination.

## Start Promo in MIX_ENV=dev

To start your Phoenix server in development mode, do:

```
$ MIX_ENV=dev mix deps.get # Install dependencies with `
$ MIX_ENV=dev mix ecto.setup # Create and migrate your database
$ MIX_ENV=dev GMAPS_API_KEY=google-maps-api-key BASE_URL_DIRECTIONS=https://maps.googleapis.com/maps/api/directions/ mix phx.server # Start "Promo"
```

*NB:*

* leaving `MIX_ENV=$ENV` out defaults mix' operations to `dev` mode.
* leaving `GMAPS_API_KEY=google-maps-api-key` & `BASE_URL_DIRECTIONS=https://maps.googleapis.com/maps/api/directions/` out will cause the HttpClient to behave in an unpredictable manner (crash!). 


Now you can visit [`localhost:4000`](http://localhost:4000) from your browser and access the api from
[`localhost:4000/api`](http://localhost:4000/api).

## Start Promo in MIX_ENV=prod

### Building a vanilla release

```
$ mix deps.get --only prod
$ MIX_ENV=prod mix compile
$ npm run deploy --prefix assets # build your assets in production mode
$ mix phx.digest # compress and tag your assets for proper caching
```

### Building a distillery release

`MIX_ENV=prod mix distillery.release # generate a release for a production environment`

If you prefer a less tedious/complete bunch of release commands, use:   
`$ npm run deploy --prefix assets && MIX_ENV=prod mix do phx.digest, release --env=prod`   
*NB* the above release steps are the gist of containerizing this app (docker).

To run the release:
`GMAPS_API_KEY=key PORT=4001 _build/prod/rel/promo/bin/promo foreground`

`:promo` prod env variables to be set:

- Mandatory:
* `BASE_URL_DIRECTIONS=https://maps.googleapis.com/maps/api/directions/`
* `GMAPS_API_KEY=google-maps-api-key`
* `DATABASE_URL=postgres://username:password@host:port/prod_db_name`

- Defaults:

* `PORT=4001`

- Must not be set but nice to have:

* `SECRET_KEY_BASE=secret_key_base`

For further information about releases and their upgrades, refer to:
https://hexdocs.pm/distillery/guides/phoenix_walkthrough.html#take-that-release-anywhere.   

## Known Issues

* API Resources are not protected using token authentication yet. As such some endpoints are freely 
exposed on the open internet that shouldn't.  
To solve this, completion of the (now in progress) Oauth2.0 scheme implementation is recommended.   
In future, Any unauthorized attempt to access these routes will be met with a code `401` & `text/plain` response body saying `Unauthenticated`.

* The original development GMaps API key is contained within the app's commit history
(not an issue once reset/changed via the developer console).

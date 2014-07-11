Ewoks
=====

# API for partners geolocalization.

This project uses Rails 4.1.1 and Ruby 2.1.2

### How to use it

To get a list of partner the base URL is this one:

`http://api.localhost.dev:3000/garages`

Is possible to add some parameters to the querystring to refine the search.
Accepted parameters are:

- country
- zip
- city
- tyrefee
- radius

__If country is null, the country of your user's authorization token will be used.__

In this case, if you are searching by a city which doesn't belong to your country, probably you will get 0 results.

You can test your connection using `curl` here some examples

`curl http://api.localhost.dev:3000/garages?country=Spain`

`curl http://api.localhost.dev:3000/garages?zip=00000`

`curl http://api.localhost.dev:3000/garages?city=Valencia`

`curl http://api.localhost.dev:3000/garages?tyre_fee=25`

`curl http://api.localhost.dev:3000/garages?city=Torino&radius=20`

`curl http://api.localhost.dev:3000/garages?country=Italy&city=10139&radius=20`

[ ![Codeship Status for norauto/Ewoks](https://www.codeship.io/projects/f3bdb640-fa05-0131-d9a6-263e5952f3ef/status)](https://www.codeship.io/projects/28984)

Ewoks
=====

# API for partners geolocalization.

This project uses Rails 4.1.1 and Ruby 2.1.2

### How to use it

Before all you need to get your authorization token from the application.

Login in `http://yourdomain/login` with your _API_ user and get (or regenerate it) from the panel.

To explore the _JSON_ response you can use _curl_

#####Usage

To get a list of partner the base URL is this one:

`curl -H "Authorization: Token token=yourtoken" http://yourdomain/api/v1/garages.json`

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

`curl -H "Authorization: Token token=yourtoken" http://yourdomain/api/v1/garages.json?country=Spain`

`curl -H "Authorization: Token token=yourtoken" http://yourdomain/api/v1/garages.json?zip=00000`

`curl -H "Authorization: Token token=yourtoken" http://yourdomain/api/v1/garages.json?city=Valencia`

`curl -H "Authorization: Token token=yourtoken" http://yourdomain/api/v1/garages.json?price=25`

`curl -H "Authorization: Token token=yourtoken" http://yourdomain/api/v1/garages.json?min_price=25&max_price=50`

`curl -H "Authorization: Token token=yourtoken" http://yourdomain/api/v1/garages.json?rim=steel`

`curl -H "Authorization: Token token=yourtoken" http://yourdomain/api/v1/garages.json?vehicle=tourism`

`curl -H "Authorization: Token token=yourtoken" http://yourdomain/api/v1/garages.json?city=Torino&radius=20`

`curl -H "Authorization: Token token=yourtoken" http://yourdomain/api/v1/garages.json?country=Italy&city=10139&radius=20`

Of course it works for a unique garage too.

`curl -H "Authorization: Token token=yourtoken" http://yourdomain/api/v1/garages/1.json`

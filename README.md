[![Code Climate](https://codeclimate.com/github/jonnyjava/ewoks/badges/gpa.svg)](https://codeclimate.com/github/jonnyjava/ewoks)
[![Test Coverage](https://codeclimate.com/github/jonnyjava/ewoks/badges/coverage.svg)](https://codeclimate.com/github/jonnyjava/ewoks/coverage)
[![](https://codeship.com/projects/de30bb30-ccd8-0133-9a39-062757a4ef78/status?branch=master)](https://codeship.com/projects/de30bb30-ccd8-0133-9a39-062757a4ef78/status?branch=master)

# API for garages geolocalization.
##### v1.0.4
This project uses Rails 4.2.0 and Ruby 2.2.3

###Topics:
- General description
  - Users
  - Flow
- How to use the API
  - Examples
- Changelog

---

##General description
This platform let register and manage Garages. Here they will be able to manage all they fees, holidays and timetables.

###Users
There are 4 kind of users who can access the platform:
- Admin
- Country manager
- Garage Owner
- Api user

There is only one Admin for the application. He has the same powers of a country manager but over all countries; moreover he is the only one able to create and delete any kind of user.

A Country manager can manage garages and their owners of his country. Moreover he can activate/deactivate a garage when he consider that the information about the garage provided by his owners is enough or not.

A garage owner can manage only his own garage, creating, deleting and updating his fees, timetables and holidays.

The api user let developers to generate an API token to connect external applications to the json API.

### Flow
Two public form are availables to be embedded as iframes ```server_URL\country code\public_form``` and ```server_URL\country code\wizard```. Both let garage owners to register in our platform but ```public_form``` is a big one-page form, and ```wizard``` is step by step.

Once a owner completes the form (or the first step in case of the wizard), he receives a first email to verify that his email addres is real. In this moment the ```STATUS``` of his garage is ```To confirm```. In the email he receives there is a link with an unique token to confirm that the address is real. Once he clicks it, the status of the garage became ```disabled```.
*Only the country manager have the power to enable a disabled garage.* (or disable an enabled one.) *A garage owner cannot activate himself.*

---

## How to use the API

Before all you need to get your authorization token from the application.

Login in `http://yourdomain/login` with your _API_ user and get (or regenerate it) from the panel.

To explore the _JSON_ response you can use _curl_

###Examples

To get a list of garage the base URL is this one:

`curl -H "Authorization: Token token=yourtoken" http://yourdomain/api/v1/garages.json`

Is possible to add some parameters to the querystring to refine the search.
Accepted parameters are:

- country
- zip
- city
- tyrefee
- radius distance from a given zip or city

__If country is null, the country of your user's authorization token will be used.__

In this case, if you are searching by a city which doesn't belong to your country, probably you will get 0 results.

You can test your connection using `curl` here some examples

`curl -H "Authorization: Token token=yourtoken" "http://yourdomain/api/v1/garages.json?country=Spain"`

`curl -H "Authorization: Token token=yourtoken" "http://yourdomain/api/v1/garages.json?zip=00000"`

`curl -H "Authorization: Token token=yourtoken" "http://yourdomain/api/v1/garages.json?city=Valencia"`

`curl -H "Authorization: Token token=yourtoken" "http://yourdomain/api/v1/garages.json?price=25"`

`curl -H "Authorization: Token token=yourtoken" "http://yourdomain/api/v1/garages.json?price_min=25&price_max=50"`

`curl -H "Authorization: Token token=yourtoken" "http://yourdomain/api/v1/garages.json?rim=steel"`

`curl -H "Authorization: Token token=yourtoken" "http://yourdomain/api/v1/garages.json?vehicle=tourism"`

`curl -H "Authorization: Token token=yourtoken" "http://yourdomain/api/v1/garages.json?city=Torino&radius=20"`

`curl -H "Authorization: Token token=yourtoken" "http://yourdomain/api/v1/garages.json?country=Italy&city=10139&radius=20"`

Of course it works for a unique garage too.

`curl -H "Authorization: Token token=yourtoken" "http://yourdomain/api/v1/garages/1.json"`

---

## Changelog

- v1.0.4 The story starts here


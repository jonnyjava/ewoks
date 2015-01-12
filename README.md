# API for partners geolocalization.
##### v1.0.3
This project uses Rails 4.1.1 and Ruby 2.1.2

###Topics:
- General description
  - Users
  - Flow
- How to use the API
  - Examples
- Techical details
  - Servers and deployments
  - TDD
- Changelog
___
##General description
This platform let register and manage GaragePartners. Here they will be able to manage all they fees for mounting tyres, holidays and timetables. 

###Users
There are 4 kind of users who can access the platform:
- Admin
- Country manager
- Garage Owner
- Api user

There is only one Admin for the application. He has the same powers of a country manager but over all countries; moreover he is the only one able to create and delete any kind of user.

A Country manager can manage garages and their owners of his country. Moreover he can activate/deactivate a partner when he consider that the information about the garage provided by his owners is enough or not.

A garage owner can manage only his own garage, creating, deleting and updating his fees, timetables and holidays.

The api user let developers to generate an API token to connect external applications to the json API.

### Flow
Two public form are availables to be embedded as iframes ```fittingpartners.norauto.com\country code\public_form``` and ```fittingpartners.norauto.com\country code\wizard```. Both let garage owners to register in our platform but ```public_form``` is a big one-page form, and ```wizard``` is step by step.

Once a owner completes the form (or the first step in case of the wizard), he receives a first email to verify that his email addres is real. In this moment the ```STATUS``` of his garage is ```To confirm```. In the email he receives there is a link with an unique token to confirm that the address is real. Once he clicks it, the status of the garage became ```disabled```. 
*Only the country manager have the power to enable a disabled garage.* (or disable an enabled one.) *A garage owner cannot activate himself.* 

___
## How to use the API

Before all you need to get your authorization token from the application.

Login in `http://yourdomain/login` with your _API_ user and get (or regenerate it) from the panel.

To explore the _JSON_ response you can use _curl_

###Examples

To get a list of partner the base URL is this one:

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
___
##Techical details

###Servers and deployments
This application is hosted on ```AWS``` on classic stack of EC2+S3+RDS+oad balancers. On EC2 is installed an Ubuntu server (exactly the same version present on the ecommerce servers), the RDS is a normal MySql server installation.

Deploys can be performed with [Capistrano](http://capistranorb.com/) as usual.

###TDD
This application has been developed using Test Driven Development, which means that all its behaviour is describied by tests. Running this command ```rspec --format documentation``` the test suite works in documentation mode.
Actually the test coverage is 91%.

## Changelog
- v1.0.3 Added polish translations
___

##Contacts
If you have any question you can mail me at [acarrozzo@norauto.es](mailto:acarrozzo@norauto.es), or in case of emergency and when the first account it will be no more available at [jonnyjava.net@gmail.com](mailto:jonnyjava.net@gmail.com)
___

This document has been written using [MarkDown](https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet) syntax.


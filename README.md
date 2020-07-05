# properties_api


Rails API with an edpoint for showing real estate properties and their price within a 5km radius.

[![Build Status](https://api.travis-ci.com/skamsie/properties_api.svg?token=t8dzewnPSKqP6gNV9nsw&branch=master)](https://travis-ci.com/skamsie/properties_api/branches)

## Setup & Run

```sh

$ bundle install

# setup development and test databases
$ bundle exec rake db:create db:schema:load db:test:prepare db:seed

# run the server
$ bundle exec rails server

# run the tests
$ bundle exec rspec
```


## Example query

```sh
$ curl http://localhost:3000/properties\?lng\=13.42\&lat\=52.47\&property_type\=apartment\&marketing_type\=sell

{
  "results": [
    {
      "offer_type": "sell",
      "property_type": "apartment",
      "zip_code": "10179",
      "city": "Berlin",
      "street": "Michaelkirchplatz",
      "house_number": null,
      "lng": "13.4201547",
      "lat": "52.5069238",
      "construction_year": null,
      "number_of_rooms": "2.0",
      "currency": "eur",
      "price": "193900.0"
    },
    
    ...
    ...
    
    {
      "offer_type": "sell",
      "property_type": "apartment",
      "zip_code": "10245",
      "city": "Berlin",
      "street": "Tunnelstraße",
      "house_number": "48",
      "lng": "13.47888376",
      "lat": "52.49214865",
      "construction_year": 2013,
      "number_of_rooms": "4.0",
      "currency": "eur",
      "price": "589500.0"
    }
  ],
  "status": "2343 results found."
}
```

FactoryBot.define do
  factory :property do
    offer_type { "sell" }
    property_type { "apartment" }
    zip_code { "10117" }
    city { "Berlin" }
    street { "Auguststraße" }
    house_number { 28 }
    lng { 13.397860 }
    lat { 52.527100 }
    construction_year { 1970 }
    number_of_rooms { 2 }
    currency { "eur" }
    price { 340_000 }
  end
end

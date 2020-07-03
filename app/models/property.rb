class Property < ApplicationRecord
  scope :within_5_km_from_coordinates, lambda { |lat, lng|
    where("point(#{lng}, #{lat}) <@> point(lng, lat) < 3.10686")
  }
end

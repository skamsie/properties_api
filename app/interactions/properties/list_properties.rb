class ListProperties < ActiveInteraction::Base
  @property_types = %w(apartment single_family_house)
  @marketing_types = %w(rent sell)

  float :lng, :lat
  string :property_type, :marketing_type
  validates :property_type,
            inclusion: {
              in: @property_types,
              message: "must be one of: #{@property_types.join(', ')}"
            }
  validates :marketing_type,
            inclusion: {
              in: @marketing_types,
              message: "must be one of: #{@marketing_types.join(', ')}"
            }

  def execute
    Property
      .within_5_km_from_coordinates(lat, lng)
      .where(property_type: property_type, offer_type: marketing_type)
  end
end

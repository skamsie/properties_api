class ListProperties < ActiveInteraction::Base
  PROPERTY_TYPES = %w(apartment single_family_house).freeze
  MARKETING_TYPES = %w(rent sell).freeze

  float :lng, :lat
  string :property_type, :marketing_type
  validates :property_type,
            inclusion: {
              in: PROPERTY_TYPES,
              message: "must be one of: #{PROPERTY_TYPES.join(', ')}"
            }
  validates :marketing_type,
            inclusion: {
              in: MARKETING_TYPES,
              message: "must be one of: #{MARKETING_TYPES.join(', ')}"
            }

  def execute
    Property
      .within_5_km_from_coordinates(lat, lng)
      .where(property_type: property_type, offer_type: marketing_type)
  end
end

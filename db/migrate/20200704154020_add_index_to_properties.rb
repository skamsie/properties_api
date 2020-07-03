class AddIndexToProperties < ActiveRecord::Migration[5.2]
  def change
    add_index(
      :properties, [:lat, :lng, :property_type, :offer_type]
      name: "by_coords_prop_offer"
    )
  end
end

class CreateLocations < ActiveRecord::Migration[7.0]
  def change
    create_table :locations do |t|
      t.decimal :longitude, precision: 10, scale: 6, null: false
      t.decimal :latitude, precision: 10, scale: 6, null: false
      t.string :geodetic_datum, null: false
      t.integer :coordinate_uncertainty_in_meters, null: false
      t.string :locality, null: false
      t.timestamps
    end

    # Add unique index to prevent duplicate record 
    # and speed up query
    add_index :locations, [:longitude, :latitude], unique: true
  end
end

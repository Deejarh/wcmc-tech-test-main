class SpecieLocations < ActiveRecord::Migration[7.0]
  def change
    create_table :specie_locations do |t|
      t.references :specie, null: false, foreign_key: true
      t.references :location, null: false, foreign_key: true

      t.timestamps
    end
  end
end

class CreateSpecies < ActiveRecord::Migration[7.0]
  def change
    create_table :species do |t|
      t.integer :scientific_name_id, null: false
      t.string :scientific_name, null: false
      t.string :kingdom, null: false
      t.string :phylum, null: false
      t.string :specie_class, null: true
      t.string :order, null: true
      t.string :family, null: true
      t.string :genus, null: true
      t.string :scientific_name_authorship, null: true
      t.timestamps
    end

    # This index is to speed up search for a specie
    # using the scientificNameId
    add_index :species, :scientific_name_id
  end
end

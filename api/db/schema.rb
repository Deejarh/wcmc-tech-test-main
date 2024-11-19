# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2024_11_19_222110) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "locations", force: :cascade do |t|
    t.decimal "longitude", precision: 10, scale: 6, null: false
    t.decimal "latitude", precision: 10, scale: 6, null: false
    t.string "geodetic_datum", null: false
    t.integer "coordinate_uncertainty_in_meters", null: false
    t.string "locality", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["longitude", "latitude"], name: "index_locations_on_longitude_and_latitude", unique: true
  end

  create_table "specie_locations", force: :cascade do |t|
    t.bigint "specie_id", null: false
    t.bigint "location_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["location_id"], name: "index_specie_locations_on_location_id"
    t.index ["specie_id"], name: "index_specie_locations_on_specie_id"
  end

  create_table "species", force: :cascade do |t|
    t.integer "scientific_name_id", null: false
    t.string "scientific_name", null: false
    t.string "kingdom", null: false
    t.string "phylum", null: false
    t.string "specie_class"
    t.string "order"
    t.string "family"
    t.string "genus"
    t.string "scientific_name_authorship"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["scientific_name_id"], name: "index_species_on_scientific_name_id"
  end

  add_foreign_key "specie_locations", "locations"
  add_foreign_key "specie_locations", "species", column: "specie_id"
end

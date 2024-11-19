class Location < ApplicationRecord
    has_many :specie_locations
    has_many :species, through: :specie_locations, source: :specie
end
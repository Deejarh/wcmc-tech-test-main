class Specie < ApplicationRecord
    has_many :specie_locations
    has_many :locations, through: :specie_locations
end

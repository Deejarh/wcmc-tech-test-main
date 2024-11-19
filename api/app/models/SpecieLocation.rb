class SpecieLocation < ApplicationRecord
    belongs_to :specie
    belongs_to :location
end
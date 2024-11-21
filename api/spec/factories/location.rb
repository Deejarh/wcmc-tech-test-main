FactoryBot.define do
  factory :location do
    longitude { 179.73695 }
    latitude { -16.185317 }
    geodetic_datum { "WGS84" }
    coordinate_uncertainty_in_meters { Faker::Number.between(from: 1, to: 100) }
    locality { Faker::Address.city }
  end
end
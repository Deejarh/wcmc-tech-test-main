FactoryBot.define do
  factory :specie do
    scientific_name_id { Faker::Number.unique.number(digits: 5) }
    scientific_name { "Jania adhaerens" }
    kingdom { "Animalia" }
    phylum { "Chordata" }
    specie_class { "Mammalia" }
    order { "Primates" }
    family { "Hominidae" }
    genus { "Homo" }
    scientific_name_authorship { "Linnaeus, 1758" }
  end
end
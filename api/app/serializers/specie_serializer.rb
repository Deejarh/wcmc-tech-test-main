# frozen_string_literal: true

class SpecieSerializer < ActiveModel::Serializer
    attributes :scientific_name_id, :scientific_name, :kingdom, :phylum, :specie_class,
               :order, :genus, :family, :scientific_name_authorship, :latitude, :longitude,
               :locality, :geodetic_datum, :coordinate_uncertainty_in_meters
  
    def latitude
      object.locations.first.latitude if object.locations.any?
    end
  
    def longitude
      object.locations.first.longitude if object.locations.any?
    end
  
    def locality
      object.locations.first.locality if object.locations.any?
    end
  
    def geodetic_datum
      object.locations.first.geodetic_datum if object.locations.any?
    end
  
    def coordinate_uncertainty_in_meters
      object.locations.first.coordinate_uncertainty_in_meters if object.locations.any?
    end
  end
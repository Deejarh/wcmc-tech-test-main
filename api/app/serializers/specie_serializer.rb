# frozen_string_literal: true

class SpecieSerializer < Blueprinter::Base

  fields :scientific_name_id, :scientific_name, :kingdom, :phylum, :specie_class,
         :order, :genus, :family, :scientific_name_authorship

  field :latitude do |specie, options|
    options[:location]&.latitude
  end

  field :longitude do |specie, options|
    options[:location]&.longitude
  end

  field :locality do |specie, options|
    options[:location]&.locality
  end

  field :geodetic_datum do |specie, options|
    options[:location]&.geodetic_datum
  end

  field :coordinate_uncertainty_in_meters do |specie, options|
    options[:location]&.coordinate_uncertainty_in_meters
  end
end
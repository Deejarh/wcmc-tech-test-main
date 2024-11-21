# frozen_string_literal: true
module V1
  class SpeciesController < ApplicationController
    def by_location
      latitude = params[:latitude]
      longitude = params[:longitude]

      begin
        species_data = Rails.cache.fetch("species_by_location/#{latitude}/#{longitude}", expires_in: 1.hour) do
          location = Location.find_by!(latitude:, longitude:)
          species = location.species
          SpecieSerializer.render(species, location: location)
        end

        render json: species_data, status: :ok
      rescue ActiveRecord::RecordNotFound
        render json: { error: 'Location not found' }, status: :not_found
      rescue StandardError => e
        Rails.logger.error("Error in by_location: #{e.inspect}")
        render json: { error: 'An unexpected error occurred' }, status: :internal_server_error
      end
    end

    def by_scientific_name_id
      scientific_name_id = params[:scientific_name_id]

      begin
        species_data = Rails.cache.fetch("species_by_scientific_name_id/#{scientific_name_id}", expires_in: 1.hour) do
          species = Specie.includes(:locations).where(scientific_name_id:)

          if species.any?
            species.flat_map do |specie|
              specie.locations.map do |location|
                SpecieSerializer.render_as_hash(specie, location: location)
              end
            end
          else
            nil # Cache the fact that no species were found
          end
        end

        if species_data
          render json: species_data, status: :ok
        else
          render json: { error: 'No species found with the given scientific_name_id' }, status: :not_found
        end
      rescue StandardError => e
        Rails.logger.error("Error in by_scientific_name_id: #{e.inspect}")
        render json: { error: 'An unexpected error occurred' }, status: :internal_server_error
      end
    end
  end
end
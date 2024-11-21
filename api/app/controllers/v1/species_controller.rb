# frozen_string_literal: true
module V1
  class SpeciesController < ApplicationController
    def by_location
      latitude = params[:latitude]
      longitude = params[:longitude]

      begin
        location = Location.find_by!(latitude:, longitude:)
        species = location.species.includes(:locations)
        render json: species, each_serializer: SpecieSerializer, status: :ok
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
        species = Specie.includes(:locations).where(scientific_name_id:)

        if species.any?
          species_with_locations = species.flat_map do |specie|
            specie.locations.map do |location|
              specie.as_json.except("id").merge(location.as_json)
            end
          end

          render json: species_with_locations, status: :ok
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
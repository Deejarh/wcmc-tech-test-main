require 'csv'

namespace :import do
  desc "Import species and location data from CSV"
  task species_data: :environment do
    file_path = Rails.root.join('lib', 'data', 'Survey_of_algae,_sponges,_and_ascidians,_Fiji,_2007.csv')

    # Wrap the entire import process inside a transaction
    ActiveRecord::Base.transaction do
      CSV.foreach(file_path, headers: true) do |row|
        begin
          # Find or create the specie with metadata
          specie = Specie.find_or_create_by(
            scientific_name_id: row['scientificNameID']
          ) do |sp|
            sp.scientific_name = row['scientificName']
            sp.kingdom = row['kingdom']
            sp.phylum = row['phylum']
            sp.specie_class = row['class']
            sp.order = row['order_']
            sp.genus = row['genus']
            sp.family = row['family']
            sp.scientific_name_authorship = row['scientificNameAuthorship']
          end

          puts "specie created"

          # Find or create the location with additional fields
          location = Location.find_or_create_by(
            longitude: row['decimalLongitude'],
            latitude: row['decimalLatitude']
          ) do |loc|
            loc.geodetic_datum = row['geodeticDatum']
            loc.coordinate_uncertainty_in_meters = row['coordinateUncertaintyInMeters']
            loc.locality = row['locality']
          end

          puts "location created"

          # Create the association between specie and location
          SpecieLocation.find_or_create_by(
            specie: specie,
            location: location
          )
        rescue => e
          # Log the error and raise it to trigger a rollback
          puts "Error processing row: #{row.inspect}"
          puts "Error message: #{e.message}"

          # Rollback the transaction if an error occurs
          raise ActiveRecord::Rollback
        end
      end
    end

    puts "Data import complete!"
  end
end
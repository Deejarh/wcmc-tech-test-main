require 'rails_helper'

RSpec.describe V1::SpeciesController, type: :controller do
  let!(:location1) { create(:location, latitude: -16.185317, longitude: 179.73695) }
  let!(:location2) { create(:location, latitude: -15.185317, longitude: 178.73695) }
  let!(:specie1) { create(:specie) }
  let!(:specie2) { create(:specie) }

  before do
    create(:specie_location, specie: specie1, location: location1)
    create(:specie_location, specie: specie2, location: location1)
    create(:specie_location, specie: specie1, location: location2)
  end

  shared_examples "handles unexpected errors" do
    it "returns a 500 status and error message" do
      expect(response).to have_http_status(:internal_server_error)
      expect(JSON.parse(response.body)["error"]).to eq("An unexpected error occurred")
    end
  end

  describe "GET #by_location" do
    context "when location exists" do
      it "returns species associated with the location" do
        get :by_location, params: { latitude: location1.latitude, longitude: location1.longitude }
        expect(response).to have_http_status(:ok)
        result = JSON.parse(response.body)
        expect(result.size).to eq(2)
        expect(result.first.keys).to include("scientific_name", "kingdom", "phylum", "latitude", "longitude", "locality", "geodetic_datum", "coordinate_uncertainty_in_meters")
        result.each do |species_data|
          expect(species_data["latitude"]).to eq(location1.latitude.to_s)
          expect(species_data["longitude"]).to eq(location1.longitude.to_s)
          expect(species_data["locality"]).to eq(location1.locality)
          expect(species_data["geodetic_datum"]).to eq(location1.geodetic_datum)
          expect(species_data["coordinate_uncertainty_in_meters"]).to eq(location1.coordinate_uncertainty_in_meters)
        end
      end

      it "caches the result" do
        expect(Rails.cache).to receive(:fetch).and_call_original
        get :by_location, params: { latitude: location1.latitude, longitude: location1.longitude }
        expect(response).to have_http_status(:ok)
      end
    end

    context "when location does not exist" do
      it "returns a 404 status and error message" do
        get :by_location, params: { latitude: 0.0, longitude: 0.0 }
        expect(response).to have_http_status(:not_found)
        expect(JSON.parse(response.body)["error"]).to eq("Location not found")
      end
    end

    context "when an unexpected error occurs" do
      before do
        allow(Location).to receive(:find_by!).and_raise(StandardError)
        get :by_location, params: { latitude: 10.0, longitude: 20.0 }
      end

      include_examples "handles unexpected errors"
    end
  end

  describe "GET #by_scientific_name_id" do
    context "when species exist for the given scientific_name_id" do
      it "returns species and their locations" do
        get :by_scientific_name_id, params: { scientific_name_id: specie1.scientific_name_id }
        expect(response).to have_http_status(:ok)
        result = JSON.parse(response.body)
        expect(result.size).to eq(2)
        expect(result.first.keys).to include("scientific_name", "kingdom", "phylum", "latitude", "longitude", "locality", "geodetic_datum", "coordinate_uncertainty_in_meters")
        expected_locations = [location1, location2]
        result.each_with_index do |species_data, index|
          location = expected_locations[index]
          expect(species_data["latitude"]).to eq(location.latitude.to_s)
          expect(species_data["longitude"]).to eq(location.longitude.to_s)
          expect(species_data["locality"]).to eq(location.locality)
          expect(species_data["geodetic_datum"]).to eq(location.geodetic_datum)
          expect(species_data["coordinate_uncertainty_in_meters"]).to eq(location.coordinate_uncertainty_in_meters)
          expect(species_data["scientific_name"]).to eq(specie1.scientific_name)
          expect(species_data["kingdom"]).to eq(specie1.kingdom)
          expect(species_data["phylum"]).to eq(specie1.phylum)
        end
      end

      it "caches the result" do
        expect(Rails.cache).to receive(:fetch).and_call_original
        get :by_scientific_name_id, params: { scientific_name_id: specie1.scientific_name_id }
        expect(response).to have_http_status(:ok)
      end
    end

    context "when no species exist for the given scientific_name_id" do
      it "returns a 404 status and error message" do
        get :by_scientific_name_id, params: { scientific_name_id: "nonexistent" }
        expect(response).to have_http_status(:not_found)
        expect(JSON.parse(response.body)["error"]).to eq("No species found with the given scientific_name_id")
      end
    end

    context "when an unexpected error occurs" do
      before do
        allow(Specie).to receive(:includes).and_raise(StandardError)
        get :by_scientific_name_id, params: { scientific_name_id: specie1.scientific_name_id }
      end

      include_examples "handles unexpected errors"
    end
  end
end
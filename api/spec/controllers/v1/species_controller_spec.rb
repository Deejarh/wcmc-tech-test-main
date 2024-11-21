require 'rails_helper'

RSpec.describe V1::SpeciesController, type: :controller do
  let(:location) { create(:location, latitude: -16.185317, longitude: 179.73695) }
  let(:specie) { create(:specie) }
  let(:specie_location) { create(:specie_location, specie:, location:) }

  before do
    specie_location
  end

  describe "GET #by_location" do
    context "when location exists" do
      it "returns species associated with the location" do
        get :by_location, params: { latitude: -16.185317, longitude: 179.73695 }
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body).size).to eq(1)
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
      it "returns a 500 status and error message" do
        allow(Location).to receive(:find_by!).and_raise(StandardError)
        get :by_location, params: { latitude: 10.0, longitude: 20.0 }
        expect(response).to have_http_status(:internal_server_error)
        expect(JSON.parse(response.body)["error"]).to eq("An unexpected error occurred")
      end
    end
  end

  describe "GET #by_scientific_name_id" do
    context "when species exist for the given scientific_name_id" do
      it "returns species and their locations" do
        get :by_scientific_name_id, params: { scientific_name_id: specie.scientific_name_id }
        expect(response).to have_http_status(:ok)
        result = JSON.parse(response.body)
        expect(result.size).to eq(1)
        expect(result.first["latitude"]).to eq(location.latitude.to_s)
        expect(result.first["longitude"]).to eq(location.longitude.to_s)
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
      it "returns a 500 status and error message" do
        allow(Specie).to receive(:includes).and_raise(StandardError)
        get :by_scientific_name_id, params: { scientific_name_id: specie.scientific_name_id }
        expect(response).to have_http_status(:internal_server_error)
        expect(JSON.parse(response.body)["error"]).to eq("An unexpected error occurred")
      end
    end
  end
end

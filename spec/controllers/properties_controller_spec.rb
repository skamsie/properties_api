require_relative "../rails_helper"

RSpec.describe PropertiesController do
  describe "GET /properties" do
    let!(:property_1) do
      create(
        :property, property_type: "apartment", offer_type: "sell",
        street: "Street 1", lng: "13.4216926", lat: "52.5101209"
      )
    end
    let!(:property_2) do
      create(
        :property, property_type: "single_family_house", offer_type: "rent",
        street: "Street 2", lng: "13.4491641", lat: "52.508208"
      )
    end
    let!(:property_3) do
      create(
        :property, property_type: "apartment", offer_type: "sell",
        street: "Street 3", lng: "13.4329338", lat: "52.5107275"
      )
    end
    let!(:property_4) do
      create(
        :property, property_type: "apartment", offer_type: "sell",
        street: "Street 4", lng: "14.4216926", lat: "53.5101209"
      )
    end
    let!(:property_5) do
      create(
        :property, property_type: "apartment", offer_type: "rent",
        street: "Street 5", lng: "13.4329338", lat: "52.5107275"
      )
    end

    let(:lng) { 13.42 }
    let(:lat) { 52.47 }
    let(:property_type) { "apartment" }
    let(:marketing_type) { "sell" }
    let(:params) do
      {
        lng: lng,
        lat: lat,
        property_type: property_type,
        marketing_type: marketing_type
      }
    end

    before do
      get :index, params: params
    end

    context "query for apartments to sell" do
      it "returns 200" do
        expect(response.status).to eq(200)
      end

      it "returns the correct results in the body" do
        expect(response_body[:results]).to eq(
          [
            {
              offer_type: "sell",
              property_type: "apartment",
              zip_code: "10117",
              city: "Berlin",
              street: "Street 1",
              house_number: "28",
              lng: "13.4216926",
              lat: "52.5101209",
              construction_year: 1970,
              number_of_rooms: "2.0",
              currency: "eur",
              price: "340000.0"
            },
            {
              offer_type: "sell",
              property_type: "apartment",
              zip_code: "10117",
              city: "Berlin",
              street: "Street 3",
              house_number: "28",
              lng: "13.4329338",
              lat: "52.5107275",
              construction_year: 1970,
              number_of_rooms: "2.0",
              currency: "eur",
              price: "340000.0"
            }
          ]
        )
      end

      it "status has number of results" do
        expect(response_body[:status]).to eq("2 results found.")
      end
    end

    context "query for single_family_houses to rent" do
      let(:marketing_type) { "rent" }
      let(:property_type) { "single_family_house" }

      it "returns the correct results in the body" do
        expect(response_body[:results]).to eq(
          [
            {
              offer_type: "rent",
              property_type: "single_family_house",
              zip_code: "10117",
              city: "Berlin",
              street: "Street 2",
              house_number: "28",
              lng: "13.4491641",
              lat: "52.508208",
              construction_year: 1970,
              number_of_rooms: "2.0",
              currency: "eur",
              price: "340000.0"
            }
          ]
        )
      end

      it "status has number of results" do
        expect(response_body[:status]).to eq("1 results found.")
      end
    end

    context "query for apartments to rent but outside of the 5km radius" do
      let(:lng) { 13.812 }
      let(:lat) { 52.883 }

      it "returns no results" do
        expect(response_body[:results]).to eq([])
      end

      it "status has 'no results' message" do
        expect(response_body[:status]).to eq("No results found.")
      end
    end

    context "missing lat and lon" do
      let(:params) do
        {
          property_type: property_type,
          marketing_type: marketing_type
        }
      end

      it "returns status code 422" do
        expect(response.status).to eq(422)
      end

      it "has correct error messages" do
        expect(response_body[:errors]).to match_array(
          ["lat is required", "lng is required"]
        )
      end
    end

    context "invalid lat and lon" do
      let(:lat) { "foo" }
      let(:lng) { "bar" }

      it "returns status code 422" do
        expect(response.status).to eq(422)
      end

      it "has correct error messages" do
        expect(response_body[:errors]).to match_array(
          ["lat is not a valid float", "lng is not a valid float"]
        )
      end
    end

    context "missing property_type and marketing_type" do
      let(:params) do
        {
          lat: 52.13,
          lng: 12.44
        }
      end

      it "returns status code 422" do
        expect(response.status).to eq(422)
      end

      it "has correct error messages" do
        expect(response_body[:errors]).to match_array(
          ["marketing_type is required", "property_type is required"]
        )
      end
    end

    context "invalid property_type and marketing_type" do
      let(:property_type) { "foo" }
      let(:marketing_type) { "bar" }

      it "returns status code 422" do
        expect(response.status).to eq(422)
      end

      it "has correct error messages" do
        expect(response_body[:errors]).to match_array(
          [
            "marketing_type must be one of: rent, sell",
            "property_type must be one of: apartment, single_family_house"
          ]
        )
      end
    end
  end
end

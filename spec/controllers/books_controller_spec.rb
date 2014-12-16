require "spec_helper"
require "rails_helper"
require File.expand_path("../../app/controllers/api/v1/books_controller", File.dirname(__FILE__))

describe Api::V1::BooksController do
  describe "#index" do
    it "has a 200 status code" do
      get :index, format: :json
      expect(response).to be_success
    end

    it "returns correct number of records" do
      10.times { FactoryGirl.create :book }
      get :index, format: :json
      body = JSON.parse(response.body)
      expect(body.length).to eq(10)
    end

    it "returns valid JSON data" do
      expected_record = FactoryGirl.create :book
      expected_record = expected_record.attributes.except("id")
      get :index, format: :json
      expect(response.body).to include(expected_record.to_json)
    end
  end
end

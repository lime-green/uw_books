require "spec_helper"
require "rails_helper"

describe Api::V1::BooksController do
  describe "#index" do
    it "has a 200 status code" do
      get :index, format: :json
      expect(response).to be_success
    end

    it "does not have id field" do
      FactoryGirl.create :book
      get :index, format: :json
      expect(parse_json(response.body).first.to_json).not_to have_json_path("id")
    end

    it "returns correct number of records" do
      10.times { FactoryGirl.create :book }
      get :index, format: :json
      expect(response.body).to have_json_size(10)
    end

    it "returns valid JSON data" do
      book = FactoryGirl.create :book, :with_courses

      expected_data = {
        author: book.author,
        title: book.title,
        sku: book.sku,
        price: book.price,
        stock: book.stock,
        reqopt: book.reqopt,
        created_at: book.created_at,
        updated_at: book.updated_at,
        courses: book.courses
      }

      get :index, format: :json
      expect(response.body).to include_json(expected_data.to_json).excluding("id")
    end
  end
end

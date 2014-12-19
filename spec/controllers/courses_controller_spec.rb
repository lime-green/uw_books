require 'rails_helper'

RSpec.describe Api::V1::CoursesController, :type => :controller do

  describe "#index" do
    it "has a 200 status code" do
      get :index, format: :json
      expect(response).to be_success
    end
  end

  describe "#show" do
    it "has a 200 status code" do
      get :index, format: :json
      expect(response).to be_success
    end
  end

  it "returns correct number of records" do
    10.times { FactoryGirl.create :course }
    get :index, format: :json
    expect(response.body).to have_json_size(10)
  end

  it "returns correct JSON (with newlines)" do
    book = FactoryGirl.create :book, :with_single_course
    course = book.courses.first

    expected_data = [{
      department: course.department,
      number: course.number,
      section: course.section,
      instructor: course.instructor,
      term: course.term,
      books: [
        author: book.author,
        title: book.title,
        sku: book.sku,
        price: book.price,
        stock: book.stock,
        reqopt: book.reqopt
      ]
    }]

    get :index, format: :json
    expect(response.body).to eq(JSON.pretty_generate(expected_data.as_json))
  end
end

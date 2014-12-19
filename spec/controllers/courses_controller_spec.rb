require 'rails_helper'

describe Api::V1::CoursesController, :type => :controller do

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

  describe "#show" do
    it "has a 200 status code" do
      get :show, format: :json, department: "CS", number: 145
      expect(response).to be_success
    end

    it "does not have id field" do
      course = FactoryGirl.create :course, department: "CS", number: 145
      book = FactoryGirl.create :book
      course.books << book
      course.save
      get :show, format: :json, department: "CS", number: 145
      expect(parse_json(response.body).first.to_json).not_to have_json_path("id")
    end

    it "returns correct number of records" do
      6.times do
        book = FactoryGirl.create :book
        course = FactoryGirl.create :course, department: "CS", number: "145"
        course.books << book
        course.save
      end

      5.times do
        book = FactoryGirl.create :book
        course = FactoryGirl.create :course, department: "MATH"
        course.books << book
        course.save
      end

      get :show, format: :json, department: "CS", number: 145
      expect(response.body).to have_json_size(6)
    end

    it "returns correct JSON (with newlines)" do
      course = FactoryGirl.create :course, department: "CS", number: 145
      book = FactoryGirl.create :book
      course.books << book
      course.save
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
      get :show, format: :json, department: "CS", number: 145
      expect(response.body).to eq(JSON.pretty_generate(expected_data.as_json))
    end
  end
end
require "rails_helper"

describe Api::V1::BooksController, :type => :controller do

  describe "#index" do
    it "has a 200 status code" do
      get :index, format: :json
      expect(response).to be_success
    end

    it "does not have id field" do
      FactoryGirl.create :book
      get :index, format: :json
      expect(parse_json(response.body)["books"].first.to_json).not_to have_json_path("id")
    end

    it "returns correct number of entries" do
      10.times { FactoryGirl.create :book, :with_single_course }
      get :index, format: :json
      expect(parse_json(response.body)["books"].to_json).to have_json_size(10)
    end

    it "returns correct JSON (with newlines)" do
      book = FactoryGirl.create :book, :with_single_course
      course = book.courses.first
      expected_data = {meta: {
        current_page: 1,
        next_page: nil,
        total_pages: 1,
        total_entries: 1,
        per_page: 40,
      },
      books: [
        {
          author: book.author,
          title: book.title,
          sku: book.sku,
          price: book.price,
          stock: book.stock,
          reqopt: book.reqopt,

          courses: [
            department: course.department,
            number: course.number,
            section: course.section,
            instructor: course.instructor,
            term: course.term
          ]
        }]}
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
      expect(parse_json(response.body)["books"].first.to_json).not_to have_json_path("id")
    end

    it "returns correct number of entries" do
      6.times do
        book = FactoryGirl.create :book
        course = FactoryGirl.create :course, department: "CS", number: "241"
        course.books << book
        course.save
      end

      5.times do
        book = FactoryGirl.create :book
        course = FactoryGirl.create :course, department: "CS", number: "251"
        course.books << book
        course.save
      end

      get :show, format: :json, department: "CS", number: "241"
      expect(parse_json(response.body)["books"].to_json).to have_json_size(6)
    end

    it "returns correct JSON (with newlines)" do
      course = FactoryGirl.create :course, department: "CS", number: 145
      book = FactoryGirl.create :book
      course.books << book
      course.save
      expected_data = {meta: {
        current_page: 1,
        next_page: nil,
        total_pages: 1,
        total_entries: 1,
        per_page: 40,
      },
      books: [
        {
          author: book.author,
          title: book.title,
          sku: book.sku,
          price: book.price,
          stock: book.stock,
          reqopt: book.reqopt,

          courses: [
            department: course.department,
            number: course.number,
            section: course.section,
            instructor: course.instructor,
            term: course.term
          ]
        }]}
      get :show, format: :json, department: "CS", number: 145
      expect(response.body).to eq(JSON.pretty_generate(expected_data.as_json))
    end
  end
end

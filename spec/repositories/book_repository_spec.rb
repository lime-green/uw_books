require 'spec_helper'
require 'rails_helper'

describe BookRepository do
  it "finds all books for a given course" do
    book = FactoryGirl.create :book
    course = FactoryGirl.create :course, department: "CS", number: "777"

    # create bogus course and book
    bogus_course = FactoryGirl.create :course, department: "AFM", number: "101"
    bogus_book = FactoryGirl.create :book, author: "blabla"
    bogus_course.books << bogus_book
    bogus_course.save

    course.books << book
    course.save

    actual = CourseRepository.find_by_course("CS", "777")
    expect(actual.length).to eq(1)
    expect(actual.first.books).to eq([book])
  end
end

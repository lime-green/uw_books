require 'spec_helper'
require 'rails_helper'

describe BookRepository do
  it "finds all books for a given course" do
    expected_record = FactoryGirl.create :book, department: "CS", course: "777"
    irrelevant_record = FactoryGirl.create :book, department: "AFM", course: "101"
    expect(BookRepository.find_by_course("CS", "777")).to eq([expected_record])
  end
end

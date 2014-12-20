require 'rails_helper'

describe CourseRepository do
  let (:hash) {  { department: "CS", number: "135", section: "005", term: "1149", instructor: "Brad Lushman" } }
  let! (:book) { FactoryGirl.create :book }
  let! (:course) do
    temp = FactoryGirl.build :course, department: "CS", number: "777"
    temp.books << book
    temp.save
    $course = temp
  end
  let! (:bogus_book) { FactoryGirl.create :book }
  let! (:bogus_course) do
    temp  = FactoryGirl.create :course, department: "AFM", number: "101"
    temp.books << bogus_book
    temp.save
    $bogus_course = temp
  end

  it "finds all books for a given course; department is case insensitive" do
    actual = CourseRepository.find_by_course("cS", "777")
    expect(actual.length).to eq(1)
    expect(actual.first).to eq(course)
    expect(actual.first.books.length).to eq(1)
    expect(actual.first.books).to eq([book])
  end

  it "correctly finds an equivalent course" do
    new_course = Course.create (hash)
    actual = CourseRepository.find(hash)
    expect(actual).to eq(new_course)
  end

  it "correctly sees if a record exists" do
    Course.create(hash)
    expect(CourseRepository.exists? hash).to be_truthy
  end

  context "creation" do
    it "raises an error if an incomplete hash is given" do
      expect { CourseRepository.new_record hash.excluding("section") }.to raise_error
    end

    it "correctly creates a new record" do
      expect { CourseRepository.new_record hash }.to change { Course.count }.by(1)
    end

    it "returns the required array" do
      expect(CourseRepository.required).to eq( [:department, :number, :section, :instructor, :term] )
    end
  end
end

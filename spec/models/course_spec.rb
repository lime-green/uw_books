require 'rails_helper'

RSpec.describe Course, :type => :model do

  it "treats departments with same letters but different case as invalid" do
    course = FactoryGirl.create(:course, department: "mAtH")
    dup = course.dup
    dup[:department] = "MaTh"
    expect(dup).not_to be_valid
  end

  it "saves department as uppercase" do
    course = FactoryGirl.create(:course, department: "mAtH")
    expect(course.department).to eq("MATH")
  end

  it "returns courses in ascending order" do
    second = FactoryGirl.create(:course, department: "CS", number: 135, section: "004")
    third = FactoryGirl.create(:course, department: "CS", number: 145)
    last = FactoryGirl.create(:course, department: "mAtH")
    first = FactoryGirl.create(:course, department: "CS", number: 135, section: "002")
    expect(Course.all.length).to eq(4)
    expect(Course.first).to eq(first)
    expect(Course.second).to eq(second)
    expect(Course.third).to eq(third)
    expect(Course.last).to eq(last)
  end

  context "validations" do

    let (:course) { FactoryGirl.create(:course) }

    context "duplicate" do
      let (:dup) { course.dup }

      it "does not validate" do
        expect(dup).not_to be_valid
      end

      it "does not save" do
        expect { dup.save! }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end

    %w(section department).each do |attribute|
      context attribute do
        it "can't be the empty string" do
          course[attribute] = ""
          expect(course).not_to be_valid
        end

        it "can't be blank" do
          course[attribute] = "    "
          expect(course).not_to be_valid
        end
      end
    end

    it "can't have an instructor name longer than 255" do
      course.instructor = "a" * 256
      expect(course).not_to be_valid
      course.instructor = "a"
      expect(course).to be_valid
    end

    it "must have a section of exactly three characters" do
      course.section = "03"
      expect(course).not_to be_valid
      course.section = "0003"
      expect(course).not_to be_valid
      course.section = "003"
      expect(course).to be_valid
    end

    it "must have a department of between 2 to 10 characters" do
      course.department = "a"
      expect(course).not_to be_valid
      course.department = "a" * 11
      expect(course).not_to be_valid
      course.department = "aa"
      expect(course).to be_valid
    end

    context "number" do
      it "must be a string" do
        course.number = "114A"
        course.save
        expect(Course.first.number).to eq(course.number)
      end
    end

    context "term" do
      it "must be a string" do
        course.term = "114A"
        course.save
        expect(Course.first.term).to eq(course.term)
      end

      it "must have a term number of exactly four digits" do
        course.term = 123
        expect(course).not_to be_valid
        course.term = 12345
        expect(course).not_to be_valid
        course.term = 1234
        expect(course).to be_valid
      end
    end
  end
end

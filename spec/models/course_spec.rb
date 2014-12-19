require 'rails_helper'

RSpec.describe Course, :type => :model do
  before(:each) do
    @course = FactoryGirl.create(:course, department: "mAtH")
  end

  it "saves department as uppercase" do
    saved = Course.first
    expect(saved[:department]).to eq("MATH")
  end

  it "saves courses in ascending order" do
    second = FactoryGirl.create(:course, department: "CS", number: 145)
    first = FactoryGirl.create(:course, department: "CS", number: 135)
    expect(Course.all.length).to eq(3)
    expect(Course.first).to eq(first)
    expect(Course.second).to eq(second)
    expect(Course.third).to eq(@course)
  end

  context "validations" do
    %w(instructor section department).each do |attribute|
      context attribute do
        it "can't be the empty string" do
          @course[attribute] = ""
          expect(@course).not_to be_valid
        end

        it "can't be blank" do
          @course[attribute] = "    "
          expect(@course).not_to be_valid
        end
      end
    end

    it "can't have an instructor name longer than 255" do
      @course[:instructor] = "a" * 256
      expect(@course).not_to be_valid
    end

    it "must have a section of exactly three characters" do
      @course[:section] = "03"
      expect(@course).not_to be_valid
      @course[:section] = "0003"
      expect(@course).not_to be_valid
      @course[:section] = "003"
      expect(@course).to be_valid
    end

    it "must have a department of between 2 to 10 characters" do
      @course[:department] = "a"
      expect(@course).not_to be_valid
      @course[:department] = "a" * 11
      expect(@course).not_to be_valid
    end

    it "must have a course number between 3 to 4 digits" do
      @course[:number] = 12
      expect(@course).not_to be_valid
      @course[:number] = 12345
      expect(@course).not_to be_valid
      @course[:number] = 123
      expect(@course).to be_valid
      @course[:number] = 1234
      expect(@course).to be_valid
    end

    it "must have a term number of exactly four digits" do
      @course[:term] = 123
      expect(@course).not_to be_valid
      @course[:term] = 12345
      expect(@course).not_to be_valid
      @course[:term] = 1234
      expect(@course).to be_valid
    end
  end
end

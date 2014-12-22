require 'rails_helper'

describe BookRepository do
  let (:hash) do
    {
      author: "Orson Scott-Card", title: "Ender's Game", sku: "1234567890123",
      price: 14.50, stock: 5, reqopt: true
    }
  end
  let! (:book) { FactoryGirl.create :book }
  let! (:course) do
    temp = FactoryGirl.build :course, department: "CS", number: "777", term: 1149, section: "001"
    temp.books << book
    temp.save
    $course = temp
  end
  let! (:bogus_book) { FactoryGirl.create :book }
  let! (:bogus_course) do
    temp  = FactoryGirl.build :course, department: "AFM", number: "101", term: 1151, section: "005"
    temp.books << bogus_book
    temp.save
    $bogus_course = temp
  end

  context "#where_course" do
    it "correctly filters by term" do
      actual = BookRepository.where_course(term: "1149")
      expect(actual.length).to eq(1)
      expect(actual).to eq([book])
      expect(actual.first.courses).to eq([course])
    end

    it "correctly filters by section" do
      actual = BookRepository.where_course(section: "001")
      expect(actual.length).to eq(1)
      expect(actual).to eq([book])
      expect(actual.first.courses).to eq([course])
    end

    it "correctly applies multiple filters" do
      course_2 = FactoryGirl.build :course, term: 1149, section: "003"
      course_2.books << bogus_book
      course_2.save
      actual = BookRepository.where_course(term: 1149, section: "003")
      expect(actual.length).to eq(1)
      expect(actual).to eq([bogus_book])
      expect(actual.first.courses).to eq([course_2])
    end

    it "has no false positives" do
      actual = BookRepository.where_course(section: "010")
      expect(actual.length).to eq(0)
    end
  end

  it "finds all books for a given course" do
    actual = BookRepository.find_by_course("CS", "777")
    expect(actual.length).to eq(1)
    expect(actual).to eq([book])
    expect(actual.first.courses).to eq([course])
  end

  it "correctly finds an equivalent book" do
    new_book = Book.create(hash)
    expect(BookRepository.find hash).to eq(new_book)
  end

  it "correctly sees if a record exists" do
    Book.create(hash)
    expect(BookRepository.exists? hash).to be_truthy
  end

  context "creation" do
    it "raises an error if an incomplete hash is given" do
      expect { BookRepository.new_record hash.excluding("sku") }.to raise_error
    end

    it "correctly creates a new record" do
      expect { BookRepository.new_record hash }.to change { Book.count }.by(1)
    end

    it "returns the required array" do
      expect(BookRepository.required).to eq( [:author, :title, :sku, :price, :stock, :reqopt] )
    end
  end
end

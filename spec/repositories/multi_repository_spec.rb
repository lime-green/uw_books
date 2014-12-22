require 'rails_helper'

describe MultiRepository do
  let (:course_hash) do
    {
      department: "CS", number: "135", section: "005",
      term: "1149", instructor: "Brad Lushman"
    }
  end

  let (:book_hash) do
    {
      author: "Orson Scott-Card", title: "Ender's Game", sku: "1234567890123",
      price: 14.50, stock: 5, reqopt: true
    }
  end

  let (:hash) { course_hash.merge(book_hash) }

  it "correctly prints its required attributes" do
    expect(MultiRepository.required).to match_array(
      [:author, :title, :sku,
       :price, :stock, :reqopt, :department,
       :number, :section, :instructor, :term])
  end

  context "creation" do
    it "raises an error if course attributes are missing" do
      expect do
        MultiRepository.new_record(hash.excluding("department"))
      end.to raise_error
    end

    it "raises an error if book attributes are missing" do
      expect do
        MultiRepository.new_record(hash.excluding("sku"))
      end.to raise_error
    end

    it "does not create anything if book and course already exist" do
      book = Book.create book_hash
      course = Course.create course_hash
      course.books << book; course.save
      expect { MultiRepository.new_record hash }.to_not change { Book.count }
      expect { MultiRepository.new_record hash }.to_not change { Course.count }
      expect { MultiRepository.new_record hash }.to_not change { course.books.count }
      expect { MultiRepository.new_record hash }.to_not change { book.courses.count }
    end

    it "creates a book but not a course if course already exists" do
      course = Course.create course_hash
      ic_book = Book.count
      ic_course = Course.count
      MultiRepository.new_record hash

      expect(Book.count).to eq(ic_book + 1)
      expect(Course.count).to eq(ic_course)
      expect(course.books).to eq(Book.where(book_hash))
    end

    it "creates a course but not a book if book already exists" do
      book = Book.create book_hash
      ic_book = Book.count
      ic_course = Course.count
      MultiRepository.new_record hash

      expect(Course.count).to eq(ic_course + 1)
      expect(Book.count).to eq(ic_book)
      expect(book.courses).to eq(Course.where(course_hash))
    end

    it "creates both a book and a course if none exist" do
      ic_book = Book.count
      ic_course = Course.count
      MultiRepository.new_record hash

      expect(Course.count).to eq(ic_course + 1)
      expect(Book.count).to eq(ic_book + 1)
      book = Book.find_by book_hash
      course = Course.find_by course_hash
      expect(course.books).to eq([ book ])
      expect(book.courses).to eq([ course ])
    end

    it "treats a book with same sku as a duplicate" do
      book = Book.create book_hash
      course = Course.create course_hash
      course.books << book; course.save
      ic_book = Book.count
      ic_course = Course.count
      expect { MultiRepository.new_record hash.merge title: "some_other_title" }.not_to raise_error
      expect(Book.count).to eq(ic_book)
      expect(course.books.count).to eq(ic_book)
      expect(Course.count).to eq(ic_book)
      expect(book.courses.count).to eq(ic_course)
    end
  end
end

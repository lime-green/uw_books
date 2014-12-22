class MultiRepository < Repository
  def self.exists?(hash)
  end

  def self.new_record(hash)
    book_hash = hash.slice *BookRepository.required
    course_hash = hash.slice *CourseRepository.required

    raise "Missing key in hash: #{hash}. Need: #{required}" unless param_require(hash)
    book = BookRepository.new_record(book_hash)
    course = CourseRepository.new_record(course_hash)

    course.books << book unless course.books.include?(book)
    course.save
  end

  def self.required
    BookRepository.required.concat(CourseRepository.required)
  end

end

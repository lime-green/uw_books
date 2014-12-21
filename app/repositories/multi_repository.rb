class MultiRepository < Repository
  def self.exists?(hash)
  end

  def self.new_record(hash)
    book_hash = hash.slice *BookRepository.required
    course_hash = hash.slice *CourseRepository.required

    raise "Missing key in hash: #{hash}. Need: #{required}" unless param_require(hash)
    book = BookRepository.new_record(book_hash)
    course = CourseRepository.new_record(course_hash)

    return false if !book && !course # both already exist

    if book && !course
      course = CourseRepository.find(course_hash) # find the course that already exists
    elsif !book && course
      book = BookRepository.find(sku: book_hash[:sku]) # find the book that already exists
    end

    course.books << book
    course.save
  end

  def self.required
    BookRepository.required.concat(CourseRepository.required)
  end

end

module BookRepository
  def self.find_by_course(department, course_number)
    Book.where(department: department, course: course_number)
  end
end

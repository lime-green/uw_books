module BookRepository
  def self.find_by_course(department, course_number)
    result = Course.find_by(department: department.downcase, number: course_number)
    result ? result.books : nil
  end
end

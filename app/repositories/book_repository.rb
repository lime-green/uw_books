module BookRepository
  def self.find_by_course(department, course_number)
    Course.find_by(department: department, number: course_number).books
  end
end

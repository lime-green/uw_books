module CourseRepository
  def self.find_by_course(department, course_number)
    Course.where(department: department.upcase, number: course_number)
  end
end

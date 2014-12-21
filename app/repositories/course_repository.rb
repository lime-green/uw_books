class CourseRepository < Repository

  def self.find_by_course(department, course_number)
    Course.where(department: department.upcase, number: course_number)
  end

  def self.new_record(hash)
    hash[:department].upcase!
    super(hash)
  end

  def self.required
    [:department, :number, :section, :instructor, :term]
  end

  private
  def self.model
    Course
  end
end

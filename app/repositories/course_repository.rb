class CourseRepository < Repository

  def self.find_by_course(department, course_number)
    Course.where(department: department.upcase, number: course_number)
  end

  def self.where_course(options = {})
    hash = {}
    options.each do |k, v|
      v.upcase! if k == "department"
      hash.merge! "#{k}" => v
    end

    Course.where( hash )
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

  def self.identified_by
    required
  end
end

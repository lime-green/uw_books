module BookRepository
  extend self
  def find_by_course(department, number)
    Book.all.includes(:courses).where(
    "courses.department" => department.upcase,
    "courses.number"     => number,
    )
  end
end

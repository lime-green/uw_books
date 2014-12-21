class BookRepository < Repository

  def self.find_by_course(department, number)
    Book.all.includes(:courses).where(
    "courses.department" => department.upcase,
    "courses.number"     => number,
    )
  end

  def self.required
    [:author, :title, :sku, :price, :stock, :reqopt]
  end

  private
  def self.model
    Book
  end

end

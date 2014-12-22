class BookRepository < Repository

  def self.find_by_course(department, number)
    Book.all.includes(:courses).where(
      "courses.department" => department.upcase,
      "courses.number"     => number,
    )
  end

  def self.where_course(options = {})
    hash = {}
    options.each do |k, v|
      v.upcase! if k == "department"
      hash.merge! "courses.#{k}" => v
    end

    Book.all.includes(:courses).where( hash )
  end

  def self.required
    [:author, :title, :sku, :price, :stock, :reqopt]
  end

  private
  def self.model
    Book
  end

  def self.identified_by
    [:sku]
  end
end

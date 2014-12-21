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

  def self.new_record(hash)
    raise "Missing key in hash: #{hash}. Need: #{required}" unless param_require(hash)
    model.create!(hash) unless exists?(sku: hash[:sku])
  end

  private
  def self.model
    Book
  end

end

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

  def self.new_record(hash)
    raise "Missing key in hash: #{hash}. Need: #{required}" unless param_require(hash)
    model.find_by(sku: hash[:sku]) || model.create!(hash)
  end

  private
  def self.model
    Book
  end

end

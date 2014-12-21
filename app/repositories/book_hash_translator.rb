module BookHashTranslator
  TRANSLATION = {
    author: :author,
    title: :title,
    sku: :sku,
    price: :price,
    stock: :stock,
    term: :term,
    department: :department,
    course: :number,
    section: :section,
    instructor: :instructor,
    reqopt: :reqopt
  }

  def self.translate(crawler_hash)
    {}.tap do |result|
      crawler_hash.map do |k,v|
        result[TRANSLATION[k]] = crawler_hash[k]
      end
    end
  end
end

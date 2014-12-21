module BookHashTranslator
  KEY_TRANSLATION = {
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

  VALUE_TRANSLATION = {
    reqopt: lambda { |v| v == "R" ? true : false },
    author: lambda { |v| v },
    title: lambda { |v| v },
    sku: lambda { |v| v },
    price: lambda { |v| v },
    stock: lambda { |v| v },
    term: lambda { |v| v },
    department: lambda { |v| v },
    course: lambda { |v| v },
    section: lambda { |v| v },
    instructor: lambda { |v| v },
  }

  def self.translate(crawler_hash)
    {}.tap do |result|
      crawler_hash.map do |k,v|
        result[KEY_TRANSLATION[k]] = VALUE_TRANSLATION[k].call(v)
      end
    end
  end
end

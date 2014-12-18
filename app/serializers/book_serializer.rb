class BookSerializer < ActiveModel::Serializer
  attributes :author, :title, :sku, :price, :stock, :reqopt
  has_many :courses, serializer: CoursePartialSerializer
end

class BookSerializer < ActiveModel::Serializer
  attributes :author, :title, :sku, :price, :stock, :reqopt, :created_at, :updated_at
  has_many :courses
end

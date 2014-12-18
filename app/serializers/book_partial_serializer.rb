class BookPartialSerializer < ActiveModel::Serializer
  attributes :title, :author, :sku, :price, :stock, :reqopt
end


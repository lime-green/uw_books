class BookPartialSerializer < ActiveModel::Serializer
  attributes :author, :title, :sku, :price, :stock, :reqopt
end


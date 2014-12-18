class CourseSerializer < ActiveModel::Serializer
  attributes :department, :number, :section, :instructor, :term
  has_many :books, serializer: BookPartialSerializer
end

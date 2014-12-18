class CoursePartialSerializer < ActiveModel::Serializer
  attributes :department, :number, :section, :instructor, :term
end

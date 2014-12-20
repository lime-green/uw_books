class AddIndexToCourse < ActiveRecord::Migration
  def change
    add_index :courses, [:instructor, :department, :number, :section, :term], unique: true, name: 'by_course'
  end
end

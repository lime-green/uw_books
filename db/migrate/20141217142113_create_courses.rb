class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :number, null: false, index: true
      t.string :section, null: false, index: true
      t.string :instructor, null: false
      t.string :department, null: false, index: true
      t.string :term, null: false
      t.timestamps null: false
    end
  end
end

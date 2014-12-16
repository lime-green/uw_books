class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :author, null: false
      t.string :title, null: false
      t.integer :sku, null: false, limit: 8
      t.float :price, null: false
      t.integer :stock, null: false
      t.integer :term, null: false
      t.string :department, null: false
      t.string :course, null: false
      t.string :section, null: false
      t.string :instructor, null: false
      t.boolean :reqopt, null: false

      t.timestamps null: false
    end
  end
end

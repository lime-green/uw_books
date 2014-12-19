class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :author, null: false
      t.string :title, null: false
      t.string :sku, null: false
      t.float :price, null: false
      t.integer :stock, null: false
      t.boolean :reqopt, null: false

      t.timestamps null: false
    end
  end
end

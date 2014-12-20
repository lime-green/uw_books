class AddIndexToBook < ActiveRecord::Migration
  def change
    add_index :books, :sku, unique: true
  end
end

class AddColumnsToBooks < ActiveRecord::Migration[5.2]
  def change
    add_column :books, :bookshelves_count, :integer, null: false,default:0
    add_column :books, :microposts_count, :integer, null: false,default:0
  end
end

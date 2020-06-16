class ChangeOrderColumns < ActiveRecord::Migration[5.2]
  def change
    change_column :books, :bookshelves_count, :integer, after: :rakuten_url
    change_column :books, :microposts_count, :integer, after: :bookshelves_count
    change_column :books, :avg_rate, :float, after: :microposts_count

    change_column :users, :created_at, :datetime, after: :admin
    change_column :users, :updated_at, :datetime, after: :created_at

    add_index :books, :isbn
  end
end

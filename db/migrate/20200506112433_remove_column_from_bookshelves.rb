class RemoveColumnFromBookshelves < ActiveRecord::Migration[5.2]
  def change
    remove_column :bookshelves, :title
    remove_column :bookshelves, :author
    remove_column :bookshelves, :image_url
    remove_column :bookshelves, :isbn
    remove_column :bookshelves, :publishername
    remove_column :bookshelves, :rakuten_url
    add_reference :bookshelves, :user, foreign_key: true
    add_reference :bookshelves, :book, foreign_key: true
    add_reference :bookshelves, :status, foreign_key: true
  end
end

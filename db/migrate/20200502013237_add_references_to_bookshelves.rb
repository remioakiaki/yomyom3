class AddReferencesToBookshelves < ActiveRecord::Migration[5.2]
  def change
    add_reference :bookshelves, :user, null: false, foreign_key: true
    add_reference :bookshelves, :status, null: false, foreign_key: true
  end
end

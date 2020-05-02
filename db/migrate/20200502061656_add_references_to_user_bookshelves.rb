class AddReferencesToUserBookshelves < ActiveRecord::Migration[5.2]
  def change
    add_reference :user_bookshelves, :status, foreign_key: true
  end
end

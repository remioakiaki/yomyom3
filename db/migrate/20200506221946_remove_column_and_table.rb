class RemoveColumnAndTable < ActiveRecord::Migration[5.2]
  def change
    
    # remove_foreign_key :bookshelves, :statuses
    # remove_reference :bookshelves, :user, index: true   
    # remove_foreign_key :bookshelves, :users
    # remove_reference :bookshelves, :user, index: true
    # remove_foreign_key :bookshelves, :books
    # remove_reference :bookshelves, :book, index: true

    # remove_foreign_key :user_bookshelves, :statuses
    # remove_reference :user_bookshelves, :status, index: true

    # remove_foreign_key :user_bookshelves, :users
    # remove_reference :user_bookshelves, :user, index: true
    # remove_foreign_key :user_bookshelves, :bookshelves
    # remove_reference :user_bookshelves, :bookshelf, index: true

    remove_foreign_key :records, :bookshelves
    remove_reference :records, :bookshelf, index: true

    drop_table :bookshelves
    # drop_table :user_bookshelves

  end
end

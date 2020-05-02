class CreateUserBookshelves < ActiveRecord::Migration[5.2]
  def change
    create_table :user_bookshelves do |t|
      t.references :user, foreign_key: true
      t.references :bookshelf, foreign_key: true

      t.timestamps
    end
  end
end

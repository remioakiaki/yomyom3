class CreateBookshelves < ActiveRecord::Migration[5.2]
  def change
    create_table :bookshelves do |t|
      t.references :user, foreign_key: true
      t.references :book, foreign_key: true
      t.references :status, foreign_key: true , default: 1

      t.timestamps
    end
  end
end

class Bookshelf < ApplicationRecord
  has_many :user_bookshelves, dependent: :destroy
  has_many :users, through: :user_bookshelves
end

class Status < ApplicationRecord
  has_many :bookshelves, foreign_key: 'bookshelf_id', dependent: :destroy
end

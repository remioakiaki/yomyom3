class Category < ApplicationRecord
  has_one :bookshelves , foreign_key: "category_id"
end
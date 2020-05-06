class Status < ApplicationRecord
  has_one :bookshelves, foreign_key: "bookshelves_id"
end

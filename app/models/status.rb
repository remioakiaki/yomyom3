class Status < ApplicationRecord
  has_one :user_bookshelves, foreign_key: "user_bookshelves_id"
end

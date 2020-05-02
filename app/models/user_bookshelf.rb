class UserBookshelf < ApplicationRecord
  belongs_to :user
  belongs_to :bookshelf
  belongs_to :status
end

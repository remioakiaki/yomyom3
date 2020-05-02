class UserBookshelf < ApplicationRecord
  belongs_to :user
  belongs_to :bookshelf

end

class Bookshelf < ApplicationRecord
  belongs_to :user
  belongs_to :status
end

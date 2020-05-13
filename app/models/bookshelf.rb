class Bookshelf < ApplicationRecord
  belongs_to :user
  belongs_to :book
  belongs_to :status
  belongs_to :category


end

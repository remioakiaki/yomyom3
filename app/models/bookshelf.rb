class Bookshelf < ApplicationRecord
  belongs_to :user
  belongs_to :book
  belongs_to :status
  belongs_to :category

  has_many :records

end

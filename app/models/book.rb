# frozen_string_literal: true

class Book < ApplicationRecord
  validates :title, presence: true
  validates :author, presence: true
  validates :isbn, uniqueness: true, presence: true
  has_many :microposts, dependent: :destroy
  has_many :bookshelves, dependent: :destroy
  # counter_culture :bookshelf

  paginates_per 12
end

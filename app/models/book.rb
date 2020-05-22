# frozen_string_literal: true

class Book < ApplicationRecord
  validates :title, presence: true
  validates :author, presence: true
  validates :isbn, uniqueness: true, presence: true
  has_many :microposts, dependent: :destroy
  has_many :likes, foreign_key: 'book_id', dependent: :destroy
  has_many :user, dependent: :destroy
  has_many :bookshelves, dependent: :destroy
  paginates_per 12
end

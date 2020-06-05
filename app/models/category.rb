# frozen_string_literal: true

class Category < ApplicationRecord
  has_one :bookshelves, foreign_key: 'category_id'
  validates :name, uniqueness: true, presence: true
end

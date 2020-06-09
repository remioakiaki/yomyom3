# frozen_string_literal: true

class Category < ApplicationRecord
  has_one :bookshelves, foreign_key: 'category_id'
  validates :name, presence: true
end

# frozen_string_literal: true

class Status < ApplicationRecord
  has_one :bookshelves, foreign_key: 'bookshelves_id'
  validates :name, presence: true
end

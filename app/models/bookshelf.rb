# frozen_string_literal: true

class Bookshelf < ApplicationRecord
  belongs_to :user
  belongs_to :book
  counter_culture :book
  belongs_to :status
  belongs_to :category

  has_many :records, dependent: :destroy

  paginates_per 12
end

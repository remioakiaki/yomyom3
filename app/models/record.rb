# frozen_string_literal: true

class Record < ApplicationRecord
  validates :yyyymmdd, presence: true
  validates :summinutes, presence: true, numericality: { greater_than: 0 }

  validates :minutes, numericality: { grater_than: 0 }
  validates :memo, length: { maximum: 50 }
  default_scope -> { order(updated_at: :desc) }

  before_validation :changehours

  belongs_to :user
  belongs_to :bookshelf

  paginates_per 5
  def changehours
    self.summinutes = hours * 60 + minutes
    self.summinutes /= 60
  end
end

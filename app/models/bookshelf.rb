class Bookshelf < ApplicationRecord
  belongs_to :user
  belongs_to :book
  counter_culture :book
  belongs_to :status
  belongs_to :category

  has_many :records, dependent: :destroy
  def self.ranking
    group(:book_id).order('count_book_id DESC').limit(12).count(:book_id)
  end

  def self.ranking_top
    group(:book_id).order('count_book_id DESC').limit(4).count(:book_id)
  end
end

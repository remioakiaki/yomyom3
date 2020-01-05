class Like < ApplicationRecord
  belongs_to :user
  belongs_to :book
  def self.ranking
    group(:book_id).order('count_book_id DESC').limit(12).count(:book_id)
  end

  def self.ranking_top
    group(:book_id).order('count_book_id DESC').limit(4).count(:book_id)
  end
end

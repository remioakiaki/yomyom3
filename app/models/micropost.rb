# frozen_string_literal: true

class Micropost < ApplicationRecord
  validates :user_id, presence: true
  validates :book_id, presence: true
  validates :title, length: { maximum: 50 }
  validates :content, presence: true, length: { maximum: 140 }
  validates :pictures, length: { maximum: 4,
                                 too_long: 'は%<count>枚以内で入力してください' }
  validates :rate, presence: true, numericality: { greater_than: 1 }
  belongs_to :user
  default_scope -> { order(updated_at: :desc) }
  belongs_to :book
  counter_culture :book
  mount_uploaders :pictures, ImagesUploader
  validate :picture_size

  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy

  after_save :avgrate
   
  def avgrate
    book = Book.find(self.book_id)
    book.avg_rate = book.microposts.average(:rate)
    book.save
    
    
  end

  private

  # アップロード画像のサイズを検証する
  def picture_size
    return if pictures.size < 5.megabytes

    errors.add(:pictures, 'should be less than 5MB')
  end
end

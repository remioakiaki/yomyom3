class Micropost < ApplicationRecord
   validates :user_id, presence: true
   validates :book_id, presence: true
   validates :title, length: { maximum: 50 }
   validates :content, presence: true, length: { maximum: 140 }
   validates :pictures, length: { maximum: 4,
                                  too_long: 'は%{count}枚以内で入力してください' }
   validates :rate, presence: true, numericality: { greater_than: 1 }
  belongs_to :user
   default_scope -> { order(updated_at: :desc) }
   belongs_to :book

   mount_uploader :pictures, ImagesUploader
   validate :picture_size

   has_many :comments, dependent: :destroy

  private

  # アップロード画像のサイズを検証する
  def picture_size
    errors.add(:picture, 'should be less than 5MB') if picture.size > 5.megabytes
  end
end

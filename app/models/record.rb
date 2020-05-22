class Record < ApplicationRecord
  validates :yyyymmdd, presence: true
  validates :summinutes, presence: true
  validates :memo, length: { maximum: 50 }
  default_scope -> { order(updated_at: :desc) }

  before_save :changehours

  belongs_to :user
  belongs_to :bookshelf

  def changehours
    
    self.summinutes = self.hours + self.minutes / 60
    
  end
end

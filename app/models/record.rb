class Record < ApplicationRecord
  validates :yyyymmdd, presence: true
  validates :summinutes, presence: true
  validates :memo, length: { maximum: 50 }
  default_scope -> { order(updated_at: :desc) }

  before_save :changehours

  belongs_to :user
  belongs_to :bookshelf

  def changehours
    
    self.summinutes = hours * 60 + minutes
    self.summinutes /= 60
  end
end

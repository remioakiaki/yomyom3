class Record < ApplicationRecord
  validates :yyyymmdd, presence: true
  validates :summinutes, presence: true
  validates :memo, length: { maximum: 50 }
  
  before_save :changehours

  #belongs_to :user
  belongs_to :bookshelf

  def changehours

    self.summinutes = self.hours * 60 + self.minutes
    
  end
end

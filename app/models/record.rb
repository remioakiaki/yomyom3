class Record < ApplicationRecord
  before_save :changehours

  #belongs_to :user
  belongs_to :bookshelf

  def changehours

    self.summinutes = self.hours * 60 + self.minutes
    
    
    
  end
end

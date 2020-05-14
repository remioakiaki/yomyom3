class Record < ApplicationRecord
  before_save :changehours

  #belongs_to :user
  belongs_to :bookshelf

  def changehours

    self.minutes += self.hours * 60
    
    
    
  end
end

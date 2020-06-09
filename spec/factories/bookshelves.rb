# frozen_string_literal: true

FactoryBot.define do
  factory :bookshelf, class: Bookshelf do
    association :user
    association :book 
    association :status 
    association :category 
    
  end
end

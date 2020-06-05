# frozen_string_literal: true

FactoryBot.define do
  factory :bookshelf, class: Bookshelf do
    user
    book 
    status 
    category 
  end
end

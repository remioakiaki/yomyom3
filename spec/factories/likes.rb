# frozen_string_literal: true

FactoryBot.define do
  factory :like do
    book
    user { book.user }
  end
end

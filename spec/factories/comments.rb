# frozen_string_literal: true

FactoryBot.define do
  factory :comment do
    content { 'コメント' }
    association :user
    association :micropost
  end
end

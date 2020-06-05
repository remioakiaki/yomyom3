# frozen_string_literal: true

FactoryBot.define do
  factory :like do
    micropost
    user { micropost.user }
  end
end

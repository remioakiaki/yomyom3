# frozen_string_literal: true

FactoryBot.define do
  factory :record do
    yyyymmdd { '2020-05-12' }
    hours { 1 }
    minutes { 30 }
    memo { 'テストメモ' }
  end
end

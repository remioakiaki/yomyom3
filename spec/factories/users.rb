# frozen_string_literal: true

FactoryBot.define do
  factory :user, class: User do
    name { 'TestUser' }
    sequence(:email) { |n| "tester#{n}@test.com" }
    password { 'password' }
    password_confirmation { 'password' }
    remember_digest { nil }
    admin { false }
  end

  factory :other_user, class: User do
    name { 'TestUser2' }
    sequence(:email) { |n| "tester#{n}@test2.com" }
    password { 'password' }
    password_confirmation { 'password' }
    admin { false }
  end

  factory :admin_user, class: User do
    name { 'adminuser' }
    sequence(:email) { |n| "tester#{n}@test2.com" }
    password { 'password' }
    password_confirmation { 'password' }
    admin { true }
  end
end

FactoryBot.define do
  factory :micropost do
    content { 'Rspec実施中' }
    rate { 5.0 }
    association :user
    association :book
  end
end
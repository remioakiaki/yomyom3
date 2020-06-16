# frozen_string_literal: true

User.create!(name: 'テストユーザー',
  email: 'test@test.com',
  password: 'password',
  password_confirmation: 'password',
  admin: false)

User.create!(name: '管理者ユーザー',
 email: 'admin@admin.com',
 password: 'administrator',
 password_confirmation: 'administrator',
 admin: true)

Status.create!(name: '未読')
Status.create!(name: '読書中')
Status.create!(name: '読書済')

Category.create!(name: 'カテゴリなし')
Category.create!(name: '小説')
Category.create!(name: 'ビジネス')
Category.create!(name: '自己啓発')
Category.create!(name: '資格')
Category.create!(name: 'IT')

# 10.times do
#   User.create!(
#     name:Faker::Name.name,
#     email: Faker::Internet.email,
#     password: 'password',
#     password_confirmation: 'password',
#     admin:false
#   )
# end

# 10.times do |n|
#   Relationship.create!(
#     follower_id: 1,
#     followed_id: n + 2
#   )
# end

# 5.times do
#   Record.create!(
#   user_id:1,
#   bookshelf_id: rand(1..12),
#   hours: rand(1..2),
#   minutes: rand(1..11) * 5,
#   yyyymmdd: '2020-05-08'
#   )
# end
# #rand(Date.parse('2020-5-6')..Date.parse('2020-5-12'))

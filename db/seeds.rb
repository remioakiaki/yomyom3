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

5.times do |no|
  Bookshelf.create!(title: "タイトル#{no}")
end
            
Status.create!(name:'未読')
Status.create!(name:'読書中')
Status.create!(name:'読書済')


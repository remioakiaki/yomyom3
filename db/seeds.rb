# frozen_string_literal: true

# User.create!(name: 'テストユーザー',
#   email: 'test@test.com',
#   password: 'password',
#   password_confirmation: 'password',
#   admin: false)

# User.create!(name: '管理者ユーザー',
#  email: 'admin@admin.com',
#  password: 'administrator',
#  password_confirmation: 'administrator',
#  admin: true)

Status.create!(name:'未読')
Status.create!(name:'読書中')
Status.create!(name:'読書済')

# Category.create!(name: 'カテゴリなし')
# Category.create!(name: '小説')
# Category.create!(name: 'ビジネス')
# Category.create!(name: '自己啓発')
# Category.create!(name: '資格')
# Category.create!(name: 'IT')

# Book.create!(
#   title: '100年ドラえもん　50周年メモリアルエディション 『ドラえもん』全45巻・豪華愛蔵版セット',
#   author: '藤子・F・不二雄',
#   image_url: 'https://thumbnail.image.rakuten.co.jp/@0_mall/book/cabinet/3331/9784091793331.jpg?_ex=200x200',
#   isbn: 'https://thumbnail.image.rakuten.co.jp/@0_mall/book/cabinet/3331/9784091793331.jpg?_ex=200x200',
#   publishername: '小学館',
#   rakuten_url: 'https://books.rakuten.co.jp/rb/16283607/'
# )

# 5.times do |n|
#   User.create!(
#     name:"test#{n}",
#     email: "test#{n}@test.com",
#     password: 'password',
#     password_confirmation: 'password',
#     admin:false
#   )
# end

# 10.times do
#   Record.create!(
#   user_id:2,
#   bookshelf_id: rand(2..7),
#   hours: 1,
#   minutes: 30,
#   yyyymmdd:'2020-05-12'
#   )
# end

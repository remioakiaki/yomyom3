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
Bookshelf.create!(title: 'テストブック',
                  author: 'テスト著者',
                  user_id: 1,
                  status_id: 1
                  )
Status.create!(name: '未読')
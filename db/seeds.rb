# frozen_string_literal: true

User.create!(name: 'テストユーザー',
             email: 'test@test.com',
             password: 'password',
             password_confirmation: 'password',
             admin: false)

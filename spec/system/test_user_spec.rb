# frozen_string_literal: true

require 'rails_helper'

describe 'テストユーザー制限', type: :system do
  let(:test_user) { FactoryBot.create(:user, email: 'test@test.com') }

  describe 'ユーザー関連' do
    it 'プロフィールの編集ができない' do
      sign_in_as test_user
      visit edit_user_path(test_user)
      fill_in 'user[name]', with: 'テストユーザー2'
      click_on '更新'
      expect(page).to have_content 'テストユーザーでこの操作はできません'
    end
  end
end

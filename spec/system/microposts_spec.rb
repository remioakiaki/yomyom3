# frozen_string_literal: true

require 'rails_helper'
RSpec.describe 'Microposts', type: :system,js: true do
  let!(:user) { FactoryBot.create(:user) }
  let!(:book) { FactoryBot.create(:book, isbn: '1234567890') }
  describe '投稿機能' do
    before do
      sign_in_as user
      visit book_path(book)
    end
    it '作成可' do
      expect do
        fill_in 'micropost[title]', with: 'テストタイトル'
        fill_in 'micropost[content]', with: 'テスト投稿'
        #page.all('img')[12].click
        sleep 2
        click_on 'レビューを投稿'
      end.to change{ Micropost.count }.by(1)
    end
    it '作成不可' do
      fill_in 'micropost[content]', with: ''
      click_button 'レビューを投稿'
      expect(page).to have_content '投稿内容を入力してください'
    end
  end
end
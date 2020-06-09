# frozen_string_literal: true

require 'rails_helper'
RSpec.describe 'Microposts', type: :system, js: true do
  let!(:user) { FactoryBot.create(:user, name: '一般ユーザー') }
  let!(:other_user) { FactoryBot.create(:user, name: 'その他ユーザー') }
  let!(:book) { FactoryBot.create(:book, isbn: '1234567890') }
  let!(:micropost1) { FactoryBot.create(:micropost, user: user, book: book) }
  let!(:micropost2) { FactoryBot.create(:micropost, user: other_user, book: book) }
  describe '投稿機能' do
    before do
      sign_in_as user
      visit book_path(book)
    end
    it '作成可' do
        fill_in 'micropost[content]', with: 'テスト投稿'
        fill_in 'micropost[title]', with: 'テストタイトル'
        sleep 3
        page.all('img')[8].click
        click_button 'レビューを投稿'
        expect(page).to have_content '投稿が完了しました'
    end
    it '作成不可' do
      fill_in 'micropost[content]', with: ''
      click_button 'レビューを投稿'
      expect(page).to have_content '投稿内容を入力してください'
    end
  end
  describe '編集機能' do
    describe 'ログイン前' do
      it '編集不可' do
        visit microposts_user_path(user)
        expect(page).to have_no_selector ".micropost_edit_#{micropost1.id}"
      end
    end
    describe 'ログイン後' do
      before do
        sign_in_as user
      end
      context '自分の投稿' do
        it '編集可' do
          visit microposts_user_path(user)
          find(".micropost_edit_#{micropost1.id}").click
          sleep 3
          page.all('img')[9].click
          click_button '更新'
          expect(page).to have_content '更新が完了しました'
        end
      end
      context '他人の投稿' do
        it '編集不可' do
          visit microposts_user_path(other_user)
          expect(page).to have_no_selector ".micropost_edit_#{micropost2.id}"
        end
      end
    end
  end
  describe '削除機能' do
    describe 'ログイン前' do
      it '削除不可' do
        visit microposts_user_path(user)
        expect(page).to have_no_selector ".micropost_delete_#{micropost1.id}"
      end
    end
    describe 'ログイン後' do
      before do
        sign_in_as user
      end
      context '自分の投稿' do
        it '削除可' do
          visit microposts_user_path(user)
          find(".micropost_delete_#{micropost1.id}").click
          expect(page).to have_content '削除が完了しました'
        end
      end
      context '他人の投稿' do
        it '削除不可' do
          visit microposts_user_path(other_user)
          expect(page).to have_no_selector ".micropost_delete_#{micropost2.id}"
        end
      end
    end
  end
end

# frozen_string_literal: true

require 'rails_helper'

describe '書籍登録機能', type: :system do
  let(:user) { FactoryBot.create(:user, name: '一般ユーザー') }
  let(:admin_user) { FactoryBot.create(:admin_user, name: '管理者ユーザー') }
  let!(:book) { FactoryBot.create(:book) }

  
  describe '書籍新規登録' do
    describe 'ログイン前' do
      before do
        visit new_book_path
        fill_in 'title', with: 'docker'
        click_on '書籍を検索'
      end
      it '非表示' do
        expect(page).to have_no_button '本棚追加'
        expect(page).to have_button 'レビュー一覧'
      end
    end
    describe 'ログイン後' do
      before do
        sign_in_as user
        visit new_book_path
        fill_in 'title', with: 'docker'
        click_on '書籍を検索'
      end
      describe '本棚追加時' do
        it '成功' do
          expect do
            click_on '本棚追加', match: :first 
          end.to change { Book.count }.by(1)
        end
      end
      describe 'レビュー投稿時' do
        it '成功' do
          expect do
            click_on '本棚追加', match: :first 
          end.to change { Book.count }.by(1)
        end
      end
    end
  end

  describe '書籍編集' do
    describe '管理者ユーザー' do
      it '編集可' do
        sign_in_as admin_user
        visit edit_book_path(book)
        fill_in 'book[title]', with: 'テスト'
        click_on '更新'
        expect(page).to have_content '書籍を更新しました'
      end
    end
    describe '一般ユーザー' do
      it '編集不可' do
        sign_in_as user
        visit edit_book_path(book)
        expect(page).to have_current_path root_path
        expect(page).to have_content 'こちらの操作はできません'
      end
    end
  end
  
  describe '書籍削除' do
    describe '管理者ユーザー' do
      it '削除可' do
        sign_in_as admin_user
        visit new_book_path
        expect do
          click_on 'delete', match: :first 
        end.to change { Book.count }.by(-1)   
        expect(page).to have_content '書籍を削除しました'
      end
    end
    describe '一般ユーザー' do
      it '削除不可' do
        sign_in_as user
        visit new_book_path
        expect(page).to_not have_content 'delete'
      end
    end
  end
end
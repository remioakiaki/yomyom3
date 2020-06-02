# frozen_string_literal: true

require 'rails_helper'

describe '書籍登録機能', type: :system do
  let(:user) { FactoryBot.create(:user, name: '一般ユーザー') }
  let(:admin_user) { FactoryBot.create(:admin_user, name: '管理者ユーザー') }
  let!(:book) { FactoryBot.create(:book) }

  describe '書籍新規登録' do
    context 'ログイン時' do
      before do
        sign_in_as user
      end
      it '書籍登録ができること' do
        visit new_book_path
        expect { click_on 'レビューを投稿', match: :first }.to change { Book.count }.by(1)
        
      end
    end

    describe '編集機能' do
      it '管理者は編集ができる' do
        sign_in_as admin_user
        visit edit_book_path(book)
        fill_in 'book[title]', with: 'テスト'
        click_on '更新'
        expect(page).to have_content '書籍を更新しました'
      end
      it '一般ユーザーは編集不可' do
        sign_in_as user
        visit edit_book_path(book)
        expect(page).to have_current_path root_path
      end
    end
    describe '削除機能' do
      it '管理者は編集ができる' do
        sign_in_as admin_user
        visit books_path

        expect { click_on 'delete', match: :first }.to change { Book.count }.by(-1)
        expect(page).to have_content '書籍を削除しました'
      end
      it '一般ユーザーは編集不可' do
        sign_in_as user
        visit books_path
        expect(page).to_not have_content 'delete'
      end
    end
  end
end

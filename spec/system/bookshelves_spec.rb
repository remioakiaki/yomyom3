# frozen_string_literal: true

require 'rails_helper'

describe '本棚登録機能', type: :system, js: true do
  let(:user) { FactoryBot.create(:user, name: '一般ユーザー') }
  let!(:other_user) { FactoryBot.create(:user, name: 'その他ユーザー') }
  let!(:book) { FactoryBot.create(:book) }

  let!(:bookshelf) { create(:bookshelf, user: user, book: book) }
  # let!(:bookshelf) do
  #   user.bookshelves.create(
  #     user_id: user.id, book_id: book.id
  #   )
  # end
  # let!(:other_bookshelf) do
  #   other_user.bookshelves.create(
  #     user_id: other_user.id, book_id: book.id
  #   )
  # end

  describe '本棚新規登録' do
    describe 'ログイン前' do
      before do
        visit new_book_path
        fill_in 'title', with: 'docker'
        click_on '書籍を検索'
      end
      it '登録不可' do
        expect(page).to have_no_link '本棚追加'
      end
    end
    describe 'ログイン後' do
      before do
        sign_in_as user
        visit new_book_path
      end
      context '本棚未登録時' do
        it '登録可' do
          fill_in 'title', with: 'docker'
          click_on '書籍を検索'
          expect do
            click_on '本棚追加', match: :first
          end.to change { Bookshelf.count }.by(1)
        end
      end
      context '本棚登録済み' do
        before do
          bookshelf
        end
        it '登録不可' do
          expect(page).to_not have_link '本棚追加'
        end
      end
    end
  end

  describe '本棚状態編集' do
    describe 'ログイン前' do
      it '編集不可' do
        visit user_path(user)
        expect(page).to have_no_link edit_bookshelf_path(bookshelf)
      end
    end
    describe 'ログイン後' do
      before do
        sign_in_as user
      end
      context '自分のマイページ' do
        it '編集可' do
          click_link nil, href: edit_bookshelf_path(bookshelf)
          select '読書中', from: 'bookshelf_status_id'
          select '小説', from: 'bookshelf_category_id'
          click_button '更新'
          expect(page).to have_content '編集が完了しました'
        end
      end
      context '他人のマイページ' do
        it '編集不可' do
          visit user_path(other_user)
          expect(page).to have_no_link edit_bookshelf_path(bookshelf)
        end
      end
    end
  end

  describe '本棚削除' do
    describe 'ログイン後' do
      it '削除可能' do
        sign_in_as user
        click_link nil, href: edit_bookshelf_path(bookshelf)
        click_on '本棚から削除'
        page.driver.browser.switch_to.alert.accept
        expect(page).to have_content '本棚から削除されました'
      end
    end
  end

  describe '記録、レビューボタン' do
    describe 'ログイン前' do
      it '非表示' do
        visit user_path(user)
        expect(page).to_not have_link '記録を追加'
      end
    end
    describe 'ログイン後' do
      before do
        sign_in_as user
      end
      context '自分のマイページ' do
        it '表示' do
          visit user_path(user)
          expect(page).to have_link '記録を追加'
        end
      end
      context '他人のマイページ' do
        it '非表示' do
          visit user_path(other_user)
          expect(page).to_not have_link '記録を追加'
        end
      end
    end
  end
end

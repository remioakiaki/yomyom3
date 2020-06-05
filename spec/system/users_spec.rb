# frozen_string_literal: true

require 'rails_helper'
RSpec.describe 'Users', type: :system do
  describe 'ユーザー登録機能' do
    let!(:user) { FactoryBot.create(:user, name: '一般ユーザー') }
    let!(:other_user) { FactoryBot.create(:user, name: 'その他ユーザー') }
    let!(:test_user) { FactoryBot.create(:user, email: 'test@test.com') }
    let!(:admin_user) { FactoryBot.create(:user, admin: true) }
    describe 'ユーザー新規登録' do
      describe 'ログイン前' do
        context 'フォームの入力値が正常' do
          it '新規登録が完了しログインできる' do
            visit signup_path
            fill_in 'user[name]', with: 'testuser'
            fill_in 'user[email]', with: 'ak@ak.com'
            fill_in 'user[password]', with: 'password'
            fill_in 'user[password_confirmation]', with: 'password'
            click_button '新規登録'
            expect(page).to have_content('登録成功')
            expect(page).to have_title '本棚一覧'
          end
        end
        context 'フォームの入力値が異常' do
          it 'エラー内容が表示され、リダイレクトされる' do
            visit signup_path
            fill_in 'user[name]', with: 'testuser'
            fill_in 'user[email]', with: ''
            fill_in 'user[password]', with: 'password'
            fill_in 'user[password_confirmation]', with: 'password'
            click_button '新規登録'
            expect(page).to have_content('エラーがあります')
            expect(page).to have_title '新規登録'
          end
        end
      end
      describe 'ログイン後' do
        it 'アクセスできずにマイページにリダイレクト' do
          sign_in_as user
          visit signup_path
          expect(page).to have_content('すでにログインしています')
          expect(page).to have_current_path user_path(user)
        end
      end
    end
    describe 'ユーザー編集' do
      describe 'ログイン前' do
        it '他ユーザーにはアクセスできない' do
          visit edit_user_path(user)
          expect(page).to have_content('ログインしていない状態でその操作はできません')
          expect(page).to have_current_path root_path
        end
      end
      describe 'ログイン後' do
        before do
          visit root_path
          sign_in_as user
          visit edit_user_path(user)
        end
        describe '一般ユーザー' do
          context 'フォームの入力値が正常' do
            it '編集が完了しマイページへ移動' do
              fill_in 'user[name]', with: 'テストユーザー'
              click_on '更新'
              expect(page).to have_content '更新完了'
              expect(page).to have_current_path user_path(user)
            end
          end
          context 'フォームの入力値が異常' do
            it 'エラー内容が表示され、リダイレクトされる' do
              fill_in 'user[name]', with: 'テストユーザー'
              click_on '更新'
              expect(page).to have_content '更新完了'
              expect(page).to have_current_path user_path(user)
            end
          end
          context '他ユーザーの編集を行おうとする' do
            it '他ユーザーの編集画面は開けない' do
              visit edit_user_path(other_user)
              expect(page).to have_content('他ユーザーの編集はできません')
              expect(page).to have_current_path user_path(user)
            end
          end
        end
      end
      describe 'テストユーザー' do
        before do
          sign_in_as test_user
          visit edit_user_path(test_user)
        end
        it '更新ができずにリダイレクトされる' do
          click_on '更新'
          expect(page).to have_content 'テストユーザーでこの操作はできません'
          expect(page).to have_current_path edit_user_path(test_user)
        end
      end
    end
    describe 'ユーザー確認' do
      describe 'ログイン前' do
        describe '他ユーザーを確認した時' do
          it '情報が適切に取得できる' do
            visit user_path(user)
            expect(page).to have_current_path user_path(user)
          end
        end
      end
      describe 'ログイン後' do
        before do
          sign_in_as user
        end
        describe '自ユーザーを確認した時' do
          it '情報が適切に取得できる' do
            visit user_path(user)
            expect(page).to have_current_path user_path(user)
          end
        end
        describe '他ユーザーを確認した時' do
          it '情報が適切に取得できる' do
            visit user_path(other_user)
            expect(page).to have_current_path user_path(other_user)
          end
        end
      end
    end
    describe 'ユーザー削除' do
      describe 'ログイン前' do
        it '削除不可' do
          visit users_path
          expect(page).to_not have_content 'delete'
        end
      end
      describe 'ログイン後' do
        context '一般ユーザー' do
          it '削除不可' do
            sign_in_as user
            visit users_path
            expect(page).to_not have_content 'delete'
          end
        end
        context '管理者ユーザー' do
          it '削除可' do
            sign_in_as admin_user
            visit users_path
            expect(page).to have_content 'delete'
            click_on 'delete', match: :first
            expect(page).to have_content 'ユーザーは削除されました'
            expect(page).to have_current_path users_path
          end
        end
      end
    end
  end
end

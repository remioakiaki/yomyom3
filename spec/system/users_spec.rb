# frozen_string_literal: true

require 'rails_helper'

describe 'ユーザー登録機能' do
  let!(:user) { FactoryBot.create(:user, name: '一般ユーザー') }
  let!(:other_user) { FactoryBot.create(:user, name: 'その他ユーザー') }
  let!(:admin_user) { FactoryBot.create(:user, admin: true) }
  describe 'ユーザー新規登録' do
    describe 'ログイン前' do
      context 'フォームの入力値が正常' do
        it '新規登録が完了しログインできる' do
          expect  do
            visit signup_path
            fill_in 'user[name]', with: 'testuser'
            fill_in 'user[email]', with: 'ak@ak.com'
            fill_in 'user[password]', with: 'password'
            fill_in 'user[password_confirmation]', with: 'password'
            click_button '新規登録'
          end.to change { User.count }.by(+1)
          expect(page).to have_content('登録成功')
          expect(page).to have_title '本棚一覧'
        end
      end
      context 'フォームの入力値が異常' do
        it 'エラー内容が表示され、リダイレクトされる' do
          
        end
      end
  end
   describe 'ログイン後' do
      it 'アクセスできずにマイページにリダイレクト' do

      end
   end
end


  describe 'ユーザー編集' do
    describe 'ログイン前' do
      it 'アクセスできずにリダイレクト' do
        
      end
    end
    describe 'ログイン後' do
      describe '一般ユーザー' do
        context 'フォームの入力値が正常' do
          it '新規登録が完了しログインできる' do
  
          end
        end
        context 'フォームの入力値が異常' do
          it 'エラー内容が表示され、リダイレクトされる' do
            
          end
        end
      end
      describe 'テストユーザー' do
        it '更新ができずにリダイレクトされる' do
          
        end
      end
    end
  end

  describe 'ユーザー確認' do
      describe 'ログイン前' do
        describe '他ユーザーを確認した時' do
          it '情報が適切に取得できる' do
          
          end          
        end

      end
      describe 'ログイン後' do
        describe '自ユーザーを確認した時' do
          it '情報が適切に取得できる' do
          
          end          
        end
        describe '他ユーザーを確認した時' do
          it '情報が適切に取得できる' do
          
          end          
        end
      end
  end

  describe 'ユーザー削除' do
    describe 'ログイン前' do
      it '削除不可' do
        
      end
    end
    describe 'ログイン後' do
    describe '一般ユーザー' do
      it '削除不可' do
        
      end
    end
    describe '管理者ユーザー' do
      it '削除可能' do
        
      end
    end
    end
  end
  describe 'ユーザー新規登録', type: :system do
    it '新規登録テスト' do

    end
  end

  describe '編集機能' do
    it 'プロフィール編集テスト' do
      visit root_path
      sign_in_as user
      visit edit_user_path(user)
      fill_in 'user[name]', with: 'テストユーザー'
      click_on '更新'
      expect(page).to have_content '更新完了'
    end
    it '関係ないユーザーはアクセス不可' do
      sign_in_as user
      visit edit_user_path(other_user)
      expect(page).not_to have_current_path edit_user_path(other_user)
      expect(page).to have_current_path user_path(user)
    end
  end

  describe '削除機能' do
    it '管理者ユーザーは削除可' do
      sign_in_as admin_user
      visit users_path
      expect do
        click_on 'delete', match: :first
      end.to change { User.count }.by(-1)
      expect(page).to have_content 'ユーザーは削除されました'
    end

    it '一般ユーザーは削除が表示されない' do
      sign_in_as user
      visit users_path
      expect(page).to_not have_content 'delete'
    end
    it 'ログインなしでも削除が表示されない' do
      visit users_path
      expect(page).to_not have_content 'delete'
    end
  end
end

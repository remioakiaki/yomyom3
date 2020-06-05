# frozen_string_literal: true

require 'rails_helper'

describe '閲覧ページ確認', type: :system, js: true do
  let(:user) { FactoryBot.create(:user, name: '一般ユーザー') }

  describe 'ログイン前' do
    before  do
      visit root_path
    end
    it 'ヘッダーに正しく情報が表示される' do
      expect(page).to have_link('新規登録', href: '/signup')
      expect(page).to have_link('ログイン', href: '/login')
      expect(page).to have_link('書籍検索')
      expect(page).to have_link('ユーザー検索', href: '/users')
      expect(page).to have_link('投稿検索', href: '/microposts')
      expect(page).to have_link('ランキング', href: '/books/ranking')
    end
  end

  describe 'ログイン後' do
    before do
      sign_in_as user
      visit root_path
    end
    it 'ヘッダーに正しく情報が表示される' do
      expect(page).to have_button(user.name + 'さん')
      expect(page).to have_link('書籍検索', href: '/books/new')
      expect(page).to have_link('ユーザー検索', href: '/users')
      expect(page).to have_link('投稿検索', href: '/microposts')
      expect(page).to have_link('ランキング', href: '/books/ranking')
    end

    context 'ドロップダウンをクリックした時' do
      it 'ドロップダウンメニューが正しく表示される' do
        find('.dropdown-toggle').click
        expect(page).to have_link('マイページ')
        expect(page).to have_link('マイページ')
        expect(page).to have_link('フォロー')
        expect(page).to have_link('フォロワー')
        expect(page).to have_link('ログアウト')
      end
    end
  end
end

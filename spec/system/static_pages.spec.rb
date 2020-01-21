require 'rails_helper'

describe '閲覧ページ確認', type: :system do
  let!(:user) { FactoryBot.create(:user, name: '一般ユーザー') }
  let!(:book) { FactoryBot.create(:book) }

  context "非ログイン時" do
    before do
      visit ('static_pages/home')
    end
    it '表示ページ内容の確認' do
      expect(page).to have_link('新規登録', href: '/signup')
      expect(page).to have_link('ログイン', href: '/login')
      expect(page).to have_link('書籍検索', href: '/books')
      expect(page).to have_link('ユーザー検索', href: '/users')
      expect(page).to have_link('投稿検索', href: '/microposts')
      expect(page).to have_link('ランキング', href: '/books/ranking')
    end
    it '本の詳細ページには、投稿フォームが表示されない' do
      visit book_path(book)
      expect(page).to_not have_content 'レビューを投稿'
    end
  end

  context "ログイン時" do
    before do
      sign_in_as user
      visit ('static_pages/home')
    end
    it '表示ページ内容の確認' do
      expect(page).to have_link('書籍登録', href: '/books/new')
    end
  end


end
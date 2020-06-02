require 'rails_helper'
RSpec.describe 'Records', type: :system,js: true do
  let!(:user) { FactoryBot.create(:user) }
  let!(:other_user) { FactoryBot.create(:user, name: 'その他ユーザー') }
  let!(:book) { FactoryBot.create(:book, isbn: '1234567890') }
  let!(:bookshelf){ 
    user.bookshelves.create(
      user_id: user.id, book_id: book.id
    )
  }
  let!(:record) { FactoryBot.create(:record, user: user,bookshelf_id: bookshelf.id) }

  describe 'レコード登録機能' do
    it '登録可' do
      sign_in_as user
      click_on '記録を追加', match: :first
      sleep 2
      select 1, from: 'record_hours'
      select 30, from: 'record_minutes'
      click_button '追加'
      expect(page).to have_content '記録が完了しました'
    end
  end
  describe 'レコード編集機能' do
    describe 'ログイン前' do
      it '編集不可' do

      end
    end
    describe 'ログイン後' do
      before do
        sign_in_as user
        
      end
      context '自分の記録' do
        it '編集可能' do
          visit records_user_path(user)
          find(".record_edit_#{record.id}").click
          select 1, from: 'record_hours'
          click_button '更新'
          expect(page).to have_content '更新が完了しました'
        end
      end
      context '他人の記録' do
        it '編集不可' do
          visit records_user_path(other_user)
          expect(page).to have_no_selector ".record_edit_#{record.id}"
        end
      end
    end
  end

  #   describe '投稿機能' do
#     before do
#       sign_in_as user
#       visit book_path(book)
#     end
#     it '作成可' do
#       expect do
#         fill_in 'micropost[title]', with: 'テストタイトル'
#         fill_in 'micropost[content]', with: 'テスト投稿'
#         #page.all('img')[12].click
#         sleep 2
#         click_on 'レビューを投稿'
#       end.to change{ Micropost.count }.by(1)
#     end
#     it '作成不可' do
#       fill_in 'micropost[content]', with: ''
#       click_button 'レビューを投稿'
#       expect(page).to have_content '投稿内容を入力してください'
#     end
#   end
# end
end
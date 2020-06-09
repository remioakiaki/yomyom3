# frozen_string_literal: true

require 'rails_helper'
RSpec.describe 'Records', type: :system, js: true do
  
  let!(:user) { create(:user) }
  let!(:book) { create(:book) }
  let!(:status) { create(:status) }
  let!(:category) { create(:category) }
  
  let!(:other_user) { create(:user, name: 'その他ユーザー') }
  let!(:bookshelf) { create(:bookshelf,user_id: user.id,book_id: book.id,status_id:status.id,category_id:category.id ) }
  let!(:other_bookshelf){create(:bookshelf,user_id: other_user.id,book_id: book.id,status_id:status.id,category_id:category.id ) }
  let!(:record) { create(:record, user: user, bookshelf: bookshelf) }
  let!(:other_record) {create(:record, user: other_user, bookshelf: other_bookshelf) }
  
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
        visit records_user_path(user)
        expect(page).to have_no_selector ".record_edit_#{record.id}"
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
end

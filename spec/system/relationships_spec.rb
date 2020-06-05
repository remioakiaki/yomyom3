# frozen_string_literal: true

require 'rails_helper'
RSpec.describe 'Relationships', type: :system, js: true do
  describe 'フォロー機能' do
    let!(:user) { FactoryBot.create(:user, name: '一般ユーザー') }
    let!(:other_user) { FactoryBot.create(:user, name: 'その他ユーザー') }

    describe 'フォロー登録機能' do
      describe 'ログイン前' do
        describe 'ユーザー確認ページ' do
          before do
            visit user_path(user)
          end
          it '非表示' do
            expect(page).to_not have_selector ".relation-btn_#{user.id}"
          end
        end
        describe 'ユーザー一覧ページ' do
          before do
            users_path
          end
          it '非表示' do
            expect(page).to_not have_selector ".relation-btn_#{user.id}"
          end
        end
      end
      describe 'ログイン後' do
        before do
          sign_in_as user
        end
        describe '自分自身を確認' do
          describe 'ユーザー確認ページ' do
            it '非表示' do
              visit user_path(user)
              expect(page).to_not have_selector ".relation-btn_#{user.id}"
            end
          end
          describe 'ユーザー一覧ページ' do
            it '非表示' do
              visit users_path
              expect(page).to_not have_selector ".relation-btn_#{user.id}"
            end
          end
        end
        describe '他ユーザーを確認' do
          describe 'ユーザー確認ページ' do
            it '表示、増減可' do
              visit user_path(other_user)
              expect(page).to have_selector ".relation-btn_#{other_user.id}"
              relation other_user
            end
          end
          describe 'ユーザー一覧ページ' do
            it '表示、増減可' do
              visit users_path
              expect(page).to have_selector ".relation-btn_#{other_user.id}"
              relation other_user
            end
          end
        end
      end
    end
  end
end

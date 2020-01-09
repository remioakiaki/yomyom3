# frozen_string_literal: true

require 'rails_helper'

describe '投稿機能' do
  let!(:user) { FactoryBot.create(:user) }
  let!(:micropost) { FactoryBot.create(:micropost, user: user, book_id: book.id) }
  let!(:comment) { FactoryBot.create(:comment, user: user, micropost_id: micropost.id) }
  let!(:book) { FactoryBot.create(:book, isbn: '1234567890') }
  describe '投稿作成機能' do
    context 'ログイン時' do
      before do
        sign_in_as user
      end
      it 'コメント投稿ができること' do
        visit book_path(book)
        expect do
          find(".btn-opn_#{micropost.id}").click
          fill_in 'comment[content]', with: 'テストコメント'
          click_button 'コメント'
          visit current_path
        end.to change { Comment.count }.by(1)
      end
      it '入力がないとエラーになること' do
        visit book_path(book)
        find(".btn-opn_#{micropost.id}").click
        fill_in 'comment[content]', with: ''
        click_button 'コメント'
        expect(page).to have_content 'コメントを入力してください'
      end
    end
  end
  describe '投稿編集機能' do
    context 'ログイン時' do
      before do
        sign_in_as user
      end
      it '編集ができること' do
        visit book_path(book)
        find(".btn-opn_#{micropost.id}").click
        find(".comment_edit_#{comment.id}").click
        find('.edit-area').set('テスト編集')
        click_on '更新'
        expect(page).to have_content 'コメントの更新が完了しました'
      end
      it '入力がないとエラーになること' do
        visit book_path(book)
        find(".btn-opn_#{micropost.id}").click
        find(".comment_edit_#{comment.id}").click
        fill_in 'comment[content]', with: ''
        click_button '更新'
        expect(page).to have_content 'コメントを入力してください'
      end
    end
    context '非ログイン時' do
      it '編集不可' do
        visit edit_comment_path(comment)
        expect(page).to have_content 'ログインしてください'
      end
    end
  end
  describe '投稿削除機能' do
    context 'ログイン時' do
      before do
        sign_in_as user
      end
      it '削除ができる' do
        visit book_path(book)
        expect do
          find(".btn-opn_#{micropost.id}").click
          find(".comment_delete_#{comment.id}").click
        end.to change(Comment, :count).by(-1)
        expect(page).to have_content('コメントを削除しました')
      end
    end
  end
end

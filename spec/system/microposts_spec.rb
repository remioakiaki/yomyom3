# frozen_string_literal: true

require 'rails_helper'

describe '投稿機能' do
  let!(:user) { FactoryBot.create(:user) }

  let!(:book) { FactoryBot.create(:book, isbn: '1234567890') }
  let!(:micropost) { FactoryBot.create(:micropost, user: user, book_id: book.id) }
  describe '投稿作成機能' do
    context 'ログイン時' do
      before do
        sign_in_as user
      end
      # it '投稿ができること' do
      #   visit book_path(book)
      #   expect do
      #     fill_in 'micropost[title]', with: 'テストタイトル'
      #     fill_in 'micropost[content]', with: 'テスト投稿'
      # click_on 'poor', match: :first
      # find('poor').click
      # page.all("poor")[1].click
      # binding.pry
      # find('micropost[rate]', visible: false).set(5.0)
      # fill_in 'micropost[rate]', with:3.0
      # page.all(".book_rating")[0].set(3)
      # click_on '1'
      # sleep 5.0
      # find('.book_rating', visible: false).set(3)
      # find('.star-rating', visible: false).set(3)
      # find('#micropost_rate', visible: false).set(3)
      #   click_on 'レビューを投稿'
      #   binding.pry
      # end.to change { Micropost.count }.by(1)
      # expect(page).to have_content '投稿が完了しました'
      # end

      it '入力がないとエラーになること' do
        visit book_path(book)

        fill_in 'micropost[content]', with: ''
        click_button 'レビューを投稿'
        expect(page).to have_content '投稿内容を入力してください'
      end
    end
  end
  describe '投稿編集機能' do
    context 'ログイン時' do
      before do
        sign_in_as user
      end
      # it '編集ができること' do
      #   visit book_path(book)
      #   #binding.pry
      #   find(".micropost_edit_#{micropost.id}").click
      #   sleep 1.0

      #   find('.edit-area').set('テスト編集')
      #   click_on '更新'

      #   expect(page).to have_content '編集が完了しました'
      # end
      it '入力がないとエラーになること' do
        visit book_path(book)
        find(".micropost_edit_#{micropost.id}").click
        sleep 5.0
        page.all('#micropost_content')[1].set('')
        # fill_in 'micropost[content]', with: ''
        # find('#micropost_content').set('')

        click_on '更新'

        expect(page).to have_content '投稿内容を入力してください'
      end
    end
    context '非ログイン時' do
      it '編集不可' do
        visit edit_micropost_path(micropost)
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
          find(".micropost_delete_#{micropost.id}").click
        end.to change(Micropost, :count).by(-1)
        expect(page).to have_content('投稿を削除しました')
      end
    end
  end
end

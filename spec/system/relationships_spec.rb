# frozen_string_literal: true

require 'rails_helper'

describe 'フォロー機能' do
  let!(:user) { FactoryBot.create(:user, name: '一般ユーザー') }
  let!(:other_user) { FactoryBot.create(:user, name: 'その他ユーザー') }

  let(:active_relationship) do
    user.active_relationships.create(
      follower_id: user.id, followed_id: other_user.id
    )
  end
  let(:passive_relationship) do
    user.passive_relationships.create(
      follower_id: other_user.id, followed_id: user.id
    )
  end

  context 'ログインしている時' do
    before do
      sign_in_as user
    end
    it 'ユーザー画面でフォローができること' do
      visit user_path(other_user)
      expect do
        find(".relation-btn_#{other_user.id}").click_button 'フォローする'
        sleep 2
      end.to change(Relationship, :count).by(1)
    end
    it 'ユーザー画面でフォロー解除ができること' do
      active_relationship
      visit user_path(other_user)
      expect do
        find(".relation-btn_#{other_user.id}").click_button 'フォロー解除'
        sleep 2
      end.to change(Relationship, :count).by(-1)
    end
    it 'ユーザー一覧画面でフォローができること' do
      visit users_path
      expect do
        find(".relation-btn_#{other_user.id}").click_button 'フォローする'
        sleep 2
      end.to change(Relationship, :count).by(1)
    end
    it 'ユーザー一覧画面でフォロー解除ができること' do
      active_relationship
      visit users_path
      expect do
        find(".relation-btn_#{other_user.id}").click_button 'フォロー解除'
        sleep 2
      end.to change(Relationship, :count).by(-1)
    end
    it 'フォロワー一覧画面でフォローができること' do
      passive_relationship
      visit followers_user_path(user)
      expect do
        find(".relation-btn_#{other_user.id}").click_button 'フォローする'
        sleep 2
      end.to change(Relationship, :count).by(1)
    end
    it 'フォロワー一覧画面でフォロー解除ができること' do
      active_relationship
      visit following_user_path(user)
      expect do
        find(".relation-btn_#{other_user.id}").click_button 'フォロー解除'
        sleep 2
      end.to change(Relationship, :count).by(-1)
    end
  end

  context 'ログインしていない場合' do
    it 'ボタンが表示されていない' do
      visit user_path(other_user)
      expect(page).to_not have_selector ".relation-btn_#{other_user.id}"
    end
  end

  context 'フォロー時' do
    it 'フォロー解除ができる' do
      sign_in_as user
      active_relationship
      visit following_user_path(user)
      expect do
        find(".relation-btn_#{other_user.id}").click_button 'フォロー解除'
        sleep 2
      end.to change(Relationship, :count).by(-1)
    end
  end
end

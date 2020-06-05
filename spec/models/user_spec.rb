# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { FactoryBot.create(:user) }
  let(:other_user) { FactoryBot.create(:other_user) }
  let(:micropost) { FactoryBot.create(:micropost) }

  describe 'ユーザー登録できる場合' do
    it '新規登録できること' do
      expect(user).to be_valid
    end
  end
  describe 'ユーザー名を検証する場合' do
    it 'ユーザー名が無いと無効な状態であること' do
      user.name = nil
      user.valid?
      expect(user.errors[:name]).to include('を入力してください')
    end
    it 'ユーザー名が50文字超なら無効な状態であること' do
      user.name = 'a' * 51
      user.valid?
      expect(user.errors[:name]).to include('は50文字以内で入力してください')
    end
  end
  describe 'メールアドレスを検証する場合' do
    it 'メールアドレスが無いと無効な状態であること' do
      user.email = nil
      user.valid?
      expect(user.errors[:email]).to include('を入力してください')
    end
    it '重複したメールアドレスなら無効な状態であること' do
      FactoryBot.create(:user, email: 'tester@test.com')
      user.email = 'tester@test.com'
      user.valid?
      expect(user.errors[:email]).to include('はすでに存在します')
    end
    it 'メールアドレスが保存される前に小文字に変換されること' do
      user.email = 'TESTMAIL@test.com'
      user.save
      expect(user.email).to eq 'testmail@test.com'
    end
  end
  describe 'パスワードを検証する場合' do
    it 'パスワードと確認用パスワードが一致していないと無効な状態であること' do
      user.password = 'password'
      user.password_confirmation = 'invalid_password'
      user.valid?
      expect(user.errors[:password_confirmation]).to include('とパスワードの入力が一致しません')
    end

    it 'パスワードが6文字未満なら無効な状態であること' do
      user.password = user.password_confirmation = 'a' * 5
      user.valid?
      expect(user.errors[:password]).to include('は6文字以上で入力してください')
    end
  end
  describe '永続ログインの検証' do
    it '無効な状態' do
      expect(user.remember_token).to eq nil
    end
    context '永続ログインのする時' do
      before do
        user.remember
      end
      it '永続ログインが有効になる' do
        expect(user.authenticated?(user.remember_token)).to eq true
      end
      it '永続ログインの解除' do
        user.forget
        expect(user.remember_digest).to eq nil
      end
    end
  end
  describe '自己紹介を検証する場合' do
    it '100文字超だと無効な状態であること' do
      user.introduce = 'a' * 101
      user.valid?
      expect(user.errors[:introduce]).to include('は100文字以内で入力してください')
    end
  end

  describe 'フォロー関連' do
    context 'フォローしていない状態' do
      it '無効な状態' do
        expect(user.following?(other_user)).to eq false
      end
    end
    context 'フォローしたとき' do
      before do
        user.follow(other_user)
      end
      it 'フォロー状態になる' do
        expect(user.following).to include other_user
        expect(user.following?(other_user)).to eq true
      end
      it 'フォロー解除' do
        user.unfollow(other_user)
        expect(user.following?(other_user)).to eq false
      end
    end
  end
  describe 'お気に入り' do
    context 'お気に入りしてない状態' do
      it '無効な状態' do
        expect(user.likepost?(micropost)).to eq false
      end
    end
    context 'お気に入りした場合' do
      before do
        user.like(micropost)
      end
      it 'お気に入りがついた状態' do
        expect(user.likepost?(micropost)).to eq true
      end
      it 'お気に入り解除' do
        user.notlike(micropost)
        expect(user.likepost?(micropost)).to eq false
      end
    end
  end
end

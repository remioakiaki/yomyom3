# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Micropost, type: :model do
  let(:micropost) { FactoryBot.create(:micropost) }
  let(:other_micropost) { FactoryBot.create(:micropost) }

  describe '投稿が有効' do
    it '投稿ができること' do
      expect(micropost).to be_valid
    end
  end
  describe '投稿内容を検証' do
    it '投稿内容が無いとエラー' do
      micropost.content = nil
      micropost.valid?
      expect(micropost.errors[:content]).to include('を入力してください')
    end
    it '投稿内容が140文字を超えるとエラー' do
      micropost.content = 'a' * 141
      micropost.valid?
      expect(micropost.errors[:content]).to include('は140文字以内で入力してください')
    end

    it '画像が4枚を超えるとエラー' do
      micropost.pictures = %w[a b c d e]
      micropost.valid?
      expect(micropost.errors[:pictures]).to include('は4枚以内で入力してください')
    end
  end
end

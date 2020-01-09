# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:comment) { FactoryBot.create(:comment) }

  describe 'コメントが有効' do
    it 'コメントができること' do
      expect(comment).to be_valid
    end
  end
  describe 'コメント内容を検証' do
    it '投稿内容が無いとエラー' do
      comment.content = nil
      comment.valid?
      expect(comment.errors[:content]).to include('を入力してください')
    end
    it '投稿内容が100文字を超えるとエラー' do
      comment.content = 'a' * 101
      comment.valid?
      expect(comment.errors[:content]).to include('は100文字以内で入力してください')
    end
  end
end

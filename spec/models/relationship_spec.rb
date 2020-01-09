# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Relationship, type: :model do
  let(:user) { FactoryBot.create(:user, name: '一般ユーザー') }
  let(:other_user) { FactoryBot.create(:user, name: 'その他ユーザー') }

  context 'relationship' do
    it 'フォローがあれば有効' do
      relationship = Relationship.new(
        follower_id: user.id,
        followed_id: other_user.id
      )
      expect(relationship).to be_valid
    end
    it 'フォローされていれば有効' do
      relationship = Relationship.new(
        follower_id: other_user.id,
        followed_id: user.id
      )
      expect(relationship).to be_valid
    end
    it 'フォローがなければ無効' do
      relationship = Relationship.new(
        follower_id: user.id,
        followed_id: nil
      )
      expect(relationship).to_not be_valid
    end
    it 'フォローがされていなければ無効' do
      relationship = Relationship.new(
        follower_id: nil,
        followed_id: other_user.id
      )
      expect(relationship).to_not be_valid
    end
  end
end

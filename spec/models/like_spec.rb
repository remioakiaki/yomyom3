# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Like, type: :model do
  let(:user) { FactoryBot.create(:user, name: '一般ユーザー') }
  let(:book) { FactoryBot.create(:book) }
  let(:like) { FactoryBot.create(:like, user: user, book: book) }

  it 'お気に入り登録が有効である' do
    expect(like).to be_valid
  end
  it 'お気に入り登録解除が有効であること' do
    like
    expect { like.destroy }.to change { Like.count }.by(-1)
  end
end

# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Bookshelf, type: :model do
  let(:user) { FactoryBot.create(:user, name: '一般ユーザー') }
  let(:book) { FactoryBot.create(:book) }
  let(:bookshelf) { FactoryBot.create(:bookshelf)}
  describe '本棚登録' do
    it '有効' do
      expect(bookshelf).to be_valid
    end
  end
  describe '登録解除' do
    it '有効' do
     bookshelf
     expect { bookshelf.destroy }.to change { Bookshelf.count }.by(-1)
    end
  end
end

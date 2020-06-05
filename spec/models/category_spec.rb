# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Category, type: :model do
  let!(:category) { FactoryBot.create(:category) }

  describe 'ステータス登録' do
    it '重複不可' do
      FactoryBot.create(:category, name: '小説')
      category.name = '小説'
      category.valid?
      expect(category.errors[:name]).to include('はすでに存在します')
    end
    it '空白不可' do
      category.name = nil
      category.valid?
      expect(category.errors[:name]).to include('を入力してください')
    end
  end
end

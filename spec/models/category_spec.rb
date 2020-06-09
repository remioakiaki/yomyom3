# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Category, type: :model do
  let!(:category) { FactoryBot.create(:category) }

  describe 'ステータス登録' do
    it '空白不可' do
      category.name = nil
      category.valid?
      expect(category.errors[:name]).to include('を入力してください')
    end
  end
end

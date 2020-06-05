# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Status, type: :model do
  let!(:status) { FactoryBot.create(:status) }

  describe 'ステータス登録' do
    it '重複不可' do
      FactoryBot.create(:status, name: '読書中')
      status.name = '読書中'
      status.valid?
      expect(status.errors[:name]).to include('はすでに存在します')
    end
    it '空白不可' do
      status.name = nil
      status.valid?
      expect(status.errors[:name]).to include('を入力してください')
    end
  end
end

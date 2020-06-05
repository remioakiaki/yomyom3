# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Record, type: :model do
  let(:record) { FactoryBot.create(:record) }
  #let(:other_micropost) { FactoryBot.create(:micropost) }
  describe '記録機能' do
    it ' 有効' do
      expect(record).to be_valid
    end
    context "メモが50文字を超える" do
      it '無効' do
        record.memo = 'a' * 51
        record.valid?
        expect(record.errors[:memo]).to include('は50文字以内で入力してください')
      end
      
    end
    
  end
end

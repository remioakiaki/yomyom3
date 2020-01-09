# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Book, type: :model do
  let(:book) { FactoryBot.create(:book) }

  describe 'ブックが有効' do
    it 'ブックができること' do
      expect(book).to be_valid
    end
  end
  describe 'ブック内容を検証' do
    it 'タイトルが無いとエラー' do
      book.title = nil
      book.valid?
      expect(book.errors[:title]).to include('を入力してください')
    end
    it '作者が無いとエラー' do
      book.author = nil
      book.valid?
      expect(book.errors[:author]).to include('を入力してください')
    end
    it 'isbnがないとエラー' do
      book.isbn = nil
      book.valid?
      expect(book.errors[:isbn]).to include('を入力してください')
    end
  end
end

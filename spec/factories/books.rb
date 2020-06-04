# frozen_string_literal: true

FactoryBot.define do
  factory :book do
    title { 'テストブック' }
    author { 'テスト作家' }
    image_url { 'https://thumbnail.image.rakuten.co.jp/@0_mall/book/cabinet/0339/9784297100339.jpg?_ex=200x200' }
    isbn { '123456789' }
    publishername { 'テスト出版社' }
    rakuten_url { 'test.rakuten.com' }
  end
end

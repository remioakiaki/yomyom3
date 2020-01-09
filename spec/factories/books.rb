FactoryBot.define do
  factory :book do
    title { 'テストブック' }
    author { 'テスト作家' }
    image_url { '/assets/no_image.jpg' }
    isbn { '123456789' }
    publishername { 'テスト出版社' }
    rakuten_url { 'test.rakuten.com' }
  end
end
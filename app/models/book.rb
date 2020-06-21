# frozen_string_literal: true

class Book < ApplicationRecord
  validates :title, presence: true

  validates :isbn, uniqueness: true, presence: true
  has_many :microposts, dependent: :destroy
  has_many :bookshelves, dependent: :destroy
  # counter_culture :bookshelf

  paginates_per Settings.paginate.book

  def self.by_isbn(isbn)
    results = RakutenWebService::Books::Book.search(isbn: isbn)
    Book.create(read_from_rakuten(results.first))
  end

  def self.read_from_rakuten(result)
    { title: result['title'],
      author: result['author'],
      publishername: result['publisherName'],
      image_url: result['largeImageUrl'],
      rakuten_url: result['itemUrl'],
      isbn: result['isbn'] }
  end
end

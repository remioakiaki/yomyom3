# frozen_string_literal: true

module BooksHelper
  # RakutenWebService.configure do |c|
  #   c.application_id = ENV['RAKUTEN_APPID']
  # end

  # def createbook(isbn)
  #   @book = Book.find_or_initialize_by(isbn: isbn)
  #   results = RakutenWebService::Books::Book.search(isbn: @book.isbn)
  #   @book = Book.new(read(results.first))
  # end

  # private

  # def read(result)
  #   { title: result['title'],
  #     author: result['author'],
  #     publishername: result['publisherName'],
  #     image_url: result['largeImageUrl'],
  #     rakuten_url: result['itemUrl'],
  #     isbn: result['isbn'] }
  # end
end

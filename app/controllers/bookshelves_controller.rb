class BookshelvesController < ApplicationController
  RakutenWebService.configure do |c|
    c.application_id = ENV['RAKUTEN_APPID']
  end

  def index
    
  end
  def create
    @bookshelf = Bookshelf.find_or_initialize_by(isbn: params[:isbn])
    #return if @bookshelf.persisted?

    results = RakutenWebService::Books::Book.search(isbn: @bookshelf.isbn)
    @bookshelf = Bookshelf.new(read(results.first))

    current_user.mkbksh(@bookshelf)

  end
  def show
    @bookshelf = Bookshelf.find(params[:id])
    @record = Record.new
    @records = Record.where(bookshelf_id: @bookshelf.id).includes(:user, :bookshelf)
  end
  private

  def read(result)
    { title: result['title'],
      author: result['author'],
      publishername: result['publisherName'],
      image_url: result['largeImageUrl'],
      rakuten_url: result['itemUrl'],
      isbn: result['isbn'] }
  end
end

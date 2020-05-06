class BookshelvesController < ApplicationController
  RakutenWebService.configure do |c|
    c.application_id = ENV['RAKUTEN_APPID']
  end

  def index
    
  end
  def create
    @book = Book.find(params[:book_id])
    current_user.mkbksh(@book)
    redirect_to user_path(current_user)
  end
  def show
    @bookshelf = Bookshelf.find(params[:id])
    @record = Record.new
    @records = Record.where(bookshelf_id: @bookshelf.id).includes(:user, :bookshelf)
  end

end

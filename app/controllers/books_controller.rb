# frozen_string_literal: true

class BooksController < ApplicationController
  before_action :admin_user, only: %i[destroy edit]
  RakutenWebService.configure do |c|
    c.application_id = ENV['RAKUTEN_APPID']
  end
  
  def index
    
    @q = Book.ransack(params[:q])
    @books = @q.result.order(created_at: :desc).includes(:microposts,:likes).page(params[:page]).per(12)       
    @bookshelf = Bookshelf.new
  end

  def new
    require 'rakuten_web_service'

    params[:page] = 1 if params[:page].nil?

    books = if params[:title].present? && params[:author].present?
              RakutenWebService::Books::Book.search(title: params[:title], hits: 12,
                                                    author: params[:author])

            elsif params[:title].present?
              RakutenWebService::Books::Book.search(title: params[:title], hits: 12,
                                                    page: params[:page])
            elsif params[:author].present?
              RakutenWebService::Books::Book.search(author: params[:author], hits: 12,
                                                    page: params[:page])
            end
    if books.present?
      makearray(books)
    else @books = Book.all.includes(:microposts,:bookshelves).page(params[:page]).per(12)
    end
          
    @bookshelf = Bookshelf.new
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:success] = '書籍を更新しました'
      redirect_to @book
    else
      render :edit
    end
  end

  def create
    createbook(params[:isbn])
    if @book.save
      redirect_to book_url(@book)
    else
      flash[:danger] = '書籍の登録に失敗しました'
      render new_book_path
    end
  end

  def show
    @book = Book.find(params[:id])
    @micropost = Micropost.new
    @microposts = Micropost.where(book_id: @book.id).includes(:user, :book)
  end

  def destroy
    @book = Book.find(params[:id]).destroy
    flash[:success] = '書籍を削除しました'
    redirect_to books_path
  end

  def ranking
    @ranking_counts = Like.ranking
    @books = Book.find(@ranking_counts.keys)
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

  def makearray(books)
    booksarray = []

    books.each do |item|
      book = Book.find_or_initialize_by(isbn: item['isbn']) # アイテムにユニークなコードで探索
      book.title = item['title'] # アイテムタイトル
      book.author = item['author'] # アイテムタイトル
      book.image_url = item['largeImageUrl']
      book.publishername = item['publisherName']

      booksarray << book

      @books = Kaminari.paginate_array(booksarray,
                                       total_count: books.response['count'])
                       .page(books.response['page'])
                       .per(12)
    end
  end

  def book_params
    params.require(:book).permit(:title, :author, :image_url, :isbn, :publishername)
  end

  def admin_user
    redirect_to root_url unless current_user.admin?
  end
end

# frozen_string_literal: true

class BooksController < ApplicationController
  before_action :admin_user, only: %i[destroy edit]
  RakutenWebService.configure do |c|
    c.application_id = ENV['RAKUTEN_APPID']
  end

  def new
    require 'rakuten_web_service'

    if params[:title].present? || params[:author].present?
      paramhash = makeparams(params)
      books = RakutenWebService::Books::Book.search(paramhash)
    end

    if books.present?
      makearray(books)
    else @books = Book.all.page(params[:page]).per(12)
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
    @bookshelf = Bookshelf.new
  end

  def destroy
    @book = Book.find(params[:id]).destroy
    flash[:success] = '書籍を削除しました'
    redirect_to new_book_path
  end

  def ranking
    @books = Book.all.order(bookshelves_count: :desc).limit(12)
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
                       .page(params[:page])
    end
  end

  def book_params
    params.require(:book).permit(:title, :author, :image_url, :isbn, :publishername)
  end

  def admin_user
    return if current_user.admin?

    flash[:danger] = 'こちらの操作はできません'
    redirect_to root_url
  end

  def makeparams(params)
    params[:page] = 1 if params[:page].nil?
    params[:hits] = 12

    hash = params.permit!.to_hash.symbolize_keys.slice(:title, :author, :page, :hits)
    hash.map do |k, v|
      hash.except!(k) if v.blank?
    end
    hash # ハッシュを返す
  end
end

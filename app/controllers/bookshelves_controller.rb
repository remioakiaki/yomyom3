# frozen_string_literal: true

class BookshelvesController < ApplicationController
  before_action :correct_user, only: %i[edit update destroy]
  def create
    @bookshelf = current_user.bookshelves.build(bookshelf_params)
    if params[:bookshelf][:book_id].empty?
      @book = Book.by_isbn(params[:isbn])
      @bookshelf.book_id = @book.id
    else
      @book = Book.find(params[:bookshelf][:book_id])
    end
    @bookshelf.save
  end

  def edit
    @bookshelf = Bookshelf.find(params[:id])
    @book = Book.find(@bookshelf.book_id)
  end

  def update
    @bookshelf = Bookshelf.find(params[:id])

    if @bookshelf.update(bookshelf_params)
      flash[:success] = '編集が完了しました'
      redirect_back(fallback_location: root_path)
    else
      respond_to :js
    end
  end

  def destroy
    @bookshelf = Bookshelf.find(params[:id])
    @bookshelf.destroy
    if params[:bookshelf].nil?
      flash[:success] = '本棚から削除されました'
      redirect_to user_path(current_user)
    else
      @book = Book.find(params[:bookshelf][:book_id])
    end
  end

  private

  def bookshelf_params
    params.require(:bookshelf).permit(:user_id, :book_id, :status_id, :category_id)
  end

  def correct_user
    @bookshelf = Bookshelf.find(params[:id])
    redirect_to(current_user) unless @bookshelf.user_id == current_user.id
  end
end

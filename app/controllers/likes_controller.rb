class LikesController < ApplicationController
  def create
    @book = Book.find(params[:book_id])
    current_user.like(@book)
    @book.reload
  end

  def destroy
    @book = Book.find(params[:book_id])
    current_user.notlike(@book)
    @book.reload
  end

  private

  def like_params
    params.permit(:user_id, :book_id)
  end
end

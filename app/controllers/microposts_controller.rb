# frozen_string_literal: true

class MicropostsController < ApplicationController
  before_action :logged_in_user, only: %i[create edit destroy]
  before_action :correct_user,   only: %i[destroy edit]

  def create
    @micropost = current_user.microposts.build(micropost_params)
    @book = Book.find(params[:book_id])
    @micropost.book_id = @book.id

    if @micropost.save
      flash[:success] = '投稿が完了しました'
      redirect_to book_path(@book)
    else
      respond_to :js

    end
  end

  def edit
    @micropost = Micropost.find(params[:id])
    @book = Book.find(@micropost.book_id)
    @micropost.rate = 0
  end

  def update
    @micropost = Micropost.find(params[:id])
    @book = Book.find(params[:book_id])

    if @micropost.update(micropost_params)
      flash[:success] = '編集が完了しました'
      redirect_back(fallback_location: root_path)
    else
      respond_to :js
    end
  end

  def destroy
    @micropost = Micropost.find(params[:id])
    @micropost.destroy
    flash[:success] = '投稿を削除しました'
    redirect_back(fallback_location: root_path)
  end

  def index
    @q = Micropost.includes(:book, :user).ransack(params[:q])
    @microposts = @q.result.order(created_at: :desc)
                    .page(params[:page]).per(10)
  end

  private

  def micropost_params
    params.require(:micropost).permit(:title, :content, :updated_at, :rate, pictures: [])
  end

  def correct_user
    @micropost = current_user.microposts.find_by(id: params[:id])
    redirect_to root_url if @micropost.nil?
  end

  def logged_in_user
    return if logged_in?

    flash[:danger] = 'ログインしてください'
    redirect_to login_url
  end
end

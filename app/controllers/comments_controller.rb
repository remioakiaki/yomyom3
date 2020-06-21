# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :logged_in_user, only: %i[create edit destroy]
  before_action :correct_user,   only: %i[destroy edit]
  def create
    @comment = current_user.comments.build(comment_params)
    @micropost = Micropost.find(params[:micropost_id])
    @comment.micropost_id = @micropost.id

    @comments = Comment.where(micropost_id: params[:micropost_id]).includes(:user)

    @comment = Comment.new if @comment.save
    respond_to :js
  end

  def edit
    @comment = Comment.find(params[:id])
    # @book = Book.find(@comment.book_id)
  end

  def update
    @comment = Comment.find(params[:id])
    if @comment.update(comment_params)
      flash[:success] = 'コメントの更新が完了しました'
      redirect_back(fallback_location: root_path)
    else
      respond_to :js
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    flash[:success] = 'コメントを削除しました'
    redirect_back(fallback_location: root_path)
  end

  def index
    @comment = Comment.new
    @comments = Comment.where(micropost_id: params[:micropost_id])
    @micropost = Micropost.find(params[:micropost_id])
    respond_to :js
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end

  def correct_user
    @comment = current_user.comments.find_by(id: params[:id])
    redirect_to root_url if @comment.nil?
  end

  def logged_in_user
    return if logged_in?

    flash[:danger] = 'ログインしてください'
    redirect_to login_url
  end
end

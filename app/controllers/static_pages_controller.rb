# frozen_string_literal: true

class StaticPagesController < ApplicationController
  def home
    # if logged_in?
    #   @micropost = current_user.microposts.build
    #   @feed_items = current_user.feed.page(params[:page]).per(10)
    # else
    #   @user = User.new
    #   @feed_items = Micropost.all.page(params[:page]).per(10)
    # end
    @microposts = Micropost.all.includes(:book, :user).order(created_at: :desc).limit(3)
    @ranking_counts = Like.ranking_top
    @books = Book.find(@ranking_counts.keys)

    
    @data = Record.all.pluck(:yyyymmdd,:summinutes)
    @r = Record.all.reorder(nil).where(id:6).group(:yyyymmdd).sum(:summinutes)
  end
end

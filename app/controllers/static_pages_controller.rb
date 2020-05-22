# frozen_string_literal: true

class StaticPagesController < ApplicationController
  def home
    @microposts = Micropost.all.includes(:book, :user).order(created_at: :desc).limit(3)
    @ranking_counts = Bookshelf.ranking_top
    @books = Book.find(@ranking_counts.keys)

    
    @data = Record.all.pluck(:yyyymmdd,:summinutes)
    @r = Record.all.reorder(nil).where(id:6).group(:yyyymmdd).sum(:summinutes)
  end
end

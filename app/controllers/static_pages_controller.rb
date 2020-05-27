# frozen_string_literal: true

class StaticPagesController < ApplicationController
  def home
    @microposts = Micropost.all.includes(:book, :user)
                           .order(created_at: :desc).limit(3)
    @ranking_counts = Bookshelf.ranking_top
    @books = Book.find(@ranking_counts.keys)
  end
end

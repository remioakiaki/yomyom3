# frozen_string_literal: true

class StaticPagesController < ApplicationController
  def home
    @microposts = Micropost.all.includes(:book, :user)
                           .order(created_at: :desc).limit(3)
    
    @books = Book.all.order(bookshelves_count: :desc).limit(4)
                  
    @bookshelf = Bookshelf.new
  end
end

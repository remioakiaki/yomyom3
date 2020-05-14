class BookshelvesController < ApplicationController

  def create
    @bookshelf = current_user.bookshelves.build(bookshelf_params)
    # @bookshelf.user_id = current_user.id
    @bookshelf.book_id = params[:id]



    if @bookshelf.save 
      flash[:success] = '本棚への追加が完了しました'
      redirect_to user_path(current_user)

    end
    
  end

  def edit
    @bookshelf = Bookshelf.find(params[:id])
    @book = Book.find(@bookshelf.id)
    #@bookshelf = Bookshelf.eager_load(:book).where(id: params[:id])
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

  private
  def bookshelf_params
    params.permit(:user_id, :book_id, :status_id, :category_id)
    #params.require(:bookshelf).permit(:user_id, :book_id, :status_id, :category_id)
  end
end

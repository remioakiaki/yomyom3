class BookshelvesController < ApplicationController

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
    params.require(:bookshelf).permit(:status_id,:category_id)
  end
end

class BookshelvesController < ApplicationController
  before_action :correct_user, only: %i[edit update destroy]  
  def create
    if params[:bookshelf][:book_id].empty?
      createbook(params[:isbn])
      @book.save
      @bookshelf = current_user.bookshelves.build(bookshelf_params)
      @bookshelf.book_id = @book.id
    else
      @bookshelf = current_user.bookshelves.build(bookshelf_params)
    end
      
      if @bookshelf.save 
        flash[:success] = '本棚への追加が完了しました'
        redirect_to user_path(current_user)
      end
    
    
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
    flash[:success] = '本棚から削除されました'
    redirect_to user_path(current_user)
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

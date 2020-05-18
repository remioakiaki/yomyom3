class RecordsController < ApplicationController
  def create
    

    
    @record =  Record.new(record_params)
    # @record.hours = params[:record]["hours(4i)"]
    # @record.minutes = params[:record]["hours(5i)"]


    @bookshelf = Bookshelf.find(params[:bookshelf_id])
    @record.bookshelf_id = @bookshelf.id

    if @record.save 
      flash[:success] = '記録が完了しました'
      redirect_to records_user_path(current_user)
    else
      redirect_to bookshelf_path(@bookshelf)
    end
  end
  def new
    @bookshelf = Bookshelf.find(params[:bookshelf_id])
    @record = Record.new
  end
  def show

  end
  def edit
    @bookshelf = Bookshelf.find(params[:bookshelf_id])
    @record = Record.find(params[:id])
    
    
    
  end
  def update
    @record = Record.find(params[:id])
    # @record.hours = params[:record]["hours(4i)"]
    # @record.minutes = params[:record]["hours(5i)"]
    
    #params[:record]["hours"] =  params[:record]["hours(4i)"].to_i
    #params[:record]["minutes"] =  37
    #params[:record]["minutes"] =  params[:record]["hours(5i)"].to_i
    
    
    
    #@record.assign_attributes({ yyyymmdd: params[:yyyymmdd], hours: params[:hours],minutes: params[:minutes]})
    
    #if @record.save
    
    
    
    
    if @record.update!(record_params)
      flash[:success] = '編集が完了しました'
      redirect_back(fallback_location: root_path)
    end

  end
  def destroy
    @record = Record.find(params[:id])
    @record.destroy
    flash[:success] = '削除が完了しました'
    redirect_back(fallback_location: root_path)
  end
    private

    def record_params
      params.require(:record).permit(:hours, :minutes,:yyyymmdd,:page_amount,:memo)
    end
end

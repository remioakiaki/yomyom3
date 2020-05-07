class RecordsController < ApplicationController
    def create
        @record = current_user.records.build(record_params)
          #params[:record][:minutes] += params[:record][:hour] * 60 


        @bookshelf = Bookshelf.find(params[:bookshelf_id])
        
        
        
        @record.bookshelf_id = @bookshelf.id



        if @record.save 
            flash[:success] = '記録が完了しました'
            redirect_to bookshelf_path(@bookshelf)
        else
            redirect_to bookshelf_path(@bookshelf)
        end
    end
    private

    def record_params
      params.require(:record).permit(:hours, :minutes)
    end
end

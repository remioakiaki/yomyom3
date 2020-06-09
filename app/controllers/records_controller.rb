# frozen_string_literal: true

class RecordsController < ApplicationController
  def create
    @record = current_user.records.build(record_params)
    @bookshelf = Bookshelf.find(params[:bookshelf_id])
    @record.bookshelf_id = @bookshelf.id

    if @record.save
      flash[:success] = '記録が完了しました'
      redirect_to records_user_path(current_user)
    else
      respond_to :js
    end
  end

  def new
    @bookshelf = Bookshelf.find(params[:bookshelf_id])
    @record = Record.new
  end

  def show; end

  def edit
    @bookshelf = Bookshelf.find(params[:bookshelf_id])
    @record = Record.find(params[:id])
  end

  def update
    @record = Record.find(params[:id])
    if @record.update(record_params)
      flash[:success] = '更新が完了しました'
      redirect_back(fallback_location: root_path)
    else
      respond_to :js
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
    params.require(:record).permit(:hours, :minutes, :yyyymmdd,
                                   :page_amount, :memo, :user_id, :bookshelf_id)
  end
end

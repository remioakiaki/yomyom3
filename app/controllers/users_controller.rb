# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :admin_user, only: :destroy
  before_action :correct_user, only: %i[edit update]
  before_action :test_user, only: :update
  def show
    @user = User.find(params[:id])
    @microposts = Micropost.where(user_id: params[:id]).includes(:book, :user)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      log_in @user
      flash[:success] = '登録成功'
      redirect_to user_path(@user)
      # redirect_to root_url
    else
      render :new
    end
  end

  def edit
    # @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = '更新完了'
      redirect_to @user
    else
      render :edit
    end
  end

  def index
    @q = User.ransack(params[:q])
    @users = @q.result.order(created_at: :desc)
               .page(params[:page]).per(10)
  end

  def bookshelves
    @user = User.find(params[:id])
    @bookshelves = Bookshelf.eager_load(:book,:status,:category)
                            .where(user_id: @user.id)
                            .order('statuses.id ,categories.id')
    render :show_bookshelves
  end

  def likes
    @user = User.find(params[:id])
    @microposts = @user.likeposts

    render :show_likes
  end

  def records
    @user = User.find(params[:id])
    @records = Record.eager_load(bookshelf: :user)
                     .eager_load(bookshelf: :book)
                     .where(bookshelves:{user_id:@user.id})  
    createvar(@user.id)

    createpie('status',@user.id)
    createpie('category',@user.id)
    
    
    
    render :show_records
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = 'ユーザーは削除されました'
    redirect_to users_url
  end

  def following
    @user = User.find(params[:id])
    @users = @user.following
    render :show_follow
  end

  def followers
    @user  = User.find(params[:id])
    @users = @user.followers
    render :show_follow
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation, :picture, :introduce)
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to(current_user) unless @user == current_user
  end

  def admin_user
    redirect_to root_url unless current_user.admin?
  end

  def test_user
    return unless current_user.email == 'test@test.com'

    flash[:danger] = 'テストユーザーでこの操作はできません'
    redirect_back(fallback_location: root_path)
  end

  def createvar(user_id)
    #棒グラフのラベルを取得
    @var_labels = [*6.days.ago.to_date..Time.zone.today]
    hash = (6.days.ago.to_date..Time.zone.today).map {|day| [day,0]}.to_h
    #カテゴリーの数だけ繰り返し実施
    @r1, @r2, @r3, @r4, @r5, @r6 = (1..6).map do |i|
      datahash = Record.reorder(nil).eager_load(bookshelf: :category)
                                    .where(yyyymmdd:(6.days.ago.to_date)..(Time.zone.today))
                                    .where("categories.id=#{i} and records.user_id = #{user_id}")
                                    .group("records.yyyymmdd").order("categories.id").sum(:summinutes)
                                                          
      hash.merge(datahash).values
      
    end

    
  end
  
    def createpie(string,user_id)
      strings = string.pluralize
      
      record = Bookshelf.eager_load(string)
                        .where("bookshelves.user_id = #{user_id}")
                        .group("#{strings}.id,#{strings}.name")
                        .order("#{strings}_id").count
      
      if string == 'status'
        @pie_st_labels = record.keys
        @pie_st_values = record.values
      else
        @pie_cate_labels = record.keys
        @pie_cate_values = record.values
      end  
    end
end

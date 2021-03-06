# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :admin_user, only: :destroy
  before_action :logged_in_user, only: %i[edit update destroy]
  before_action :correct_user, only: %i[edit update]
  before_action :test_user, only: :update
  def show
    @user = User.find(params[:id])
    @bookshelves = Bookshelf.eager_load(:book, :status, :category)
                            .where(user_id: @user.id)
                            .order('statuses.id ,categories.id')
                            .page(params[:page])
  end

  def new
    if logged_in?
      flash[:danger] = 'すでにログインしています'
      redirect_to user_path(current_user)
    else
      @user = User.new
    end
  end

  def create
    @user = User.new(user_params)

    if @user.save
      log_in @user
      flash[:success] = '登録成功'
      redirect_to user_path(@user)
    else
      render :new
    end
  end

  def edit; end

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
               .page(params[:page]).page(params[:page])
  end

  def microposts
    @user = User.find(params[:id])
    @microposts = Micropost.where(user_id: params[:id]).page(params[:page]).includes(:book, :user)
    render :show_microposts
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
                     .where(bookshelves: { user_id: @user.id })
                     .page(params[:page])
    createvar(@user.id)

    createpie('status', @user.id)
    createpie('category', @user.id)

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
    return if @user == current_user

    flash[:danger] = '他ユーザーの編集はできません'
    redirect_to(current_user)
  end

  def admin_user
    redirect_to root_url unless current_user.admin?
  end

  def createvar(user_id)
    yyyymmdd = if test_user?(user_id) && params[:yyyymmdd].nil?
                 Date.parse('2020-5-12')
               elsif params[:yyyymmdd].nil?
                 Date.today
               else
                 params[:yyyymmdd].to_date
               end
    # 棒グラフのラベルを取得
    @var_labels = (yyyymmdd - 6..yyyymmdd).to_a
    hash = @var_labels.map { |day| [day, 0] }.to_h
    # カテゴリーの数だけ繰り返し実施
    @r1, @r2, @r3, @r4, @r5, @r6 = (1..6).map do |i|
      datahash = Record.reorder(nil).eager_load(bookshelf: :category)
                       .where(yyyymmdd: @var_labels)
                       .where("categories.id=#{i} and records.user_id = #{user_id}")
                       .group('records.yyyymmdd').order('categories.id')
                       .sum('round(records.summinutes,2)')

      hash.merge(datahash).values
    end
  end

  def createpie(string, user_id)
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

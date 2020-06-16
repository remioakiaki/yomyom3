# frozen_string_literal: true

class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by(email: params[:session][:email])
    if user&.authenticate(params[:session][:password])
      log_in user
      remember user
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      flash[:success] = 'ログイン成功'
      
     
      
      unless request.referer.include?('/login')
        redirect_back(fallback_location:user_path(user))
      else
        redirect_to user_path(user)
      end
    else
      flash.now[:danger] = 'emailまたはパスワードに誤りがあります'
      render 'sessions/new'
    end
  end

  def destroy
    logout if logged_in?
    flash[:success] = 'ログアウトしました'
    redirect_back(fallback_location:root_path)
  end

  private
    def checkurl?
      url = request.url

    end
end

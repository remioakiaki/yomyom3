# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include SessionsHelper

  def logged_in_user
    return if logged_in?

    flash[:danger] = 'ログインしていない状態でその操作はできません'
    redirect_to root_path
  end

  def test_user?(user_id)
    user_id == 1
  end
end

def test_user
  return unless current_user.email == 'test@test.com'

  flash[:danger] = 'テストユーザーでこの操作はできません'
  redirect_back(fallback_location: root_path)
end

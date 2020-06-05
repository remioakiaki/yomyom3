# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include SessionsHelper
  include BooksHelper

  def logged_in_user
    return if logged_in?

    flash[:danger] = 'ログインしていない状態でその操作はできません'
    redirect_to root_path
  end
  def test_user?
    current_user.email == "test@test.com"
  end
end

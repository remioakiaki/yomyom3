# frozen_string_literal: true

class LikesController < ApplicationController
  def create
    @micropost = Micropost.find(params[:micropost_id])
    current_user.like(@micropost)
    @micropost.reload
  end

  def destroy
    @micropost = Micropost.find(params[:micropost_id])
    current_user.notlike(@micropost)
    @micropost.reload
  end

  private

  def like_params
    params.permit(:user_id, :micropost_id)
  end
end

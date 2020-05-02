# frozen_string_literal: true

class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    current_user.like(likable)
    redirect_back(fallback_location: root_path)
  end

  def destroy
    current_user.dislike(likable)
    redirect_back(fallback_location: root_path)
  end

  private

  def likable
    @likable ||= params[:type].constantize.find(params[:id])
  end
end

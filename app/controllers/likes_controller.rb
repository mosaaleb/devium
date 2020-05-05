# frozen_string_literal: true

class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    current_user.like(likable)
    respond_to do |format|
      format.js { render :update }
    end
  end

  def destroy
    current_user.dislike(likable)
    respond_to do |format|
      format.js { render :update }
    end
  end

  private

  def likable
    @likable ||= params[:type].constantize.find(params[:id])
  end
end

# frozen_string_literal: true

class NotificationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @notifications = current_user.notifications.unread
  end

  def update
    if params[:id]
      notification = Notification.find(params[:id])
      notification.update(read_at: Time.zone.now)
    else
      notifications.update_all(read_at: Time.zone.now)
    end
    render json: { sucess: true }
  end

  private

  def notifications
    @notifications ||= current_user.notifications.unread
  end
end

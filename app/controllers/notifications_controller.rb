# frozen_string_literal: true

class NotificationsController < ApplicationController
  def index
    @notifications = Notification.where(recipient: current_user).unread
  end

  def update
    if params[:id]
      notification = Notification.find(params[:id])
      notification.update(read_at: Time.zone.now)
    else
      notifications = Notification.where(recipient: current_user).unread
      notifications.update_all(read_at: time.zone.now)
    end
  end
end

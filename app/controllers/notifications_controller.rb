# frozen_string_literal: true

class NotificationsController < ApplicationController
  def index
    @notifications = Notification.where(recipient: current_user).unread
  end

  def update
    @notification = Notification.find(params[:id])
    @notification.update(read_at: Time.zone.now)
  end
end

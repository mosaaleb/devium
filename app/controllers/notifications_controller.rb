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
      notifications.find_each { |n| n.update(read_at: Time.zone.now) }
    end

    respond_to do |format|
      format.js
    end
  end

  private

  def notifications
    @notifications ||= current_user.notifications.unread
  end
end

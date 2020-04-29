# frozen_string_literal: true

class NotificationsController < ApplicationController
  before_action :authenticate_user!

  def index
    notifications
  end

  def update
    if params[:id]
      notification = Notification.find(params[:id])
      notification.update(read_at: Time.zone.now)
    else
      notifications.find_each { |n| n.update(read_at: Time.zone.now) }
    end
  end

  private

  def notifications
    @notifications ||= current_user.notifications.unread
  end
end
# frozen_string_literal: true

class AddNotifierToNotification < ActiveRecord::Migration[5.2]
  def change
    add_reference :notifications, :notifier, polymorphic: true
  end
end

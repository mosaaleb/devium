# frozen_string_literal: true

class RemoveActionFromNotification < ActiveRecord::Migration[5.2]
  def change
    remove_column :notifications, :action, :string
  end
end

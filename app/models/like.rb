# frozen_string_literal: true

class Like < ApplicationRecord
  include Notifiable

  belongs_to :user
  belongs_to :likable, counter_cache: true, polymorphic: true

  private

  def notification_recipients
    [likable.user] - [user]
  end
end

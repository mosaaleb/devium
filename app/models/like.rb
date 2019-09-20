# frozen_string_literal: true

class Like < ApplicationRecord
  # Associations
  belongs_to :user
  belongs_to :likable, counter_cache: true, polymorphic: true
  has_many :notifiactions, as: :notifiable, dependent: :destroy
end

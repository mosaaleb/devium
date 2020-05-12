# frozen_string_literal: true

module Mentionable
  extend ActiveSupport::Concern

  included do
    after_create :create_mention
    has_many :mentions, as: :mentionable, dependent: :destroy
  end

  private

  def create_mention
    return unless mentioned_users

    mentioned_users.each do |mentioned|
      Mention.create(mentionable: self,
                     mentioner: user,
                     mentioned: mentioned)
    end
  end

  def mentioned_users
    mentions = content.scan(/@(\w+)/).flatten
    @mentioned_users = User.where(username: mentions)

    @mentioned_users.empty? ? nil : @mentioned_users
  end
end

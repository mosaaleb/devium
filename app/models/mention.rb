# frozen_string_literal: true

class Mention < ApplicationRecord
  include Notifiable

  belongs_to :mentioned, class_name: :User
  belongs_to :mentioner, class_name: :User
  belongs_to :mentionable, polymorphic: true

  validates :mentioned, uniqueness:
            { scope: %i[mentioner_id mentionable_id mentionable_type] }

  private

  def notification_recipients
    [mentioned] - [mentioner]
  end
end

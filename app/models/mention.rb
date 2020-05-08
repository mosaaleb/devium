# frozen_string_literal: true

class Mention < ApplicationRecord
  # associations
  belongs_to :mentioned, class_name: :User
  belongs_to :mentioner, class_name: :User
  belongs_to :mentionable, polymorphic: true

  # validations
  validates :mentioned, uniqueness:
            { scope: %i[mentioner_id mentionable_id mentionable_type] }
end

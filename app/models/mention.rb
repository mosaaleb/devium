# frozen_string_literal: true

class Mention < ApplicationRecord
  belongs_to :mentioned, class_name: :User
  belongs_to :mentioner, class_name: :User
  belongs_to :mentionable, polymorphic: true
end

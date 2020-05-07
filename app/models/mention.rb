# frozen_string_literal: true

class Mention < ApplicationRecord
  belongs_to :mentioned
  belongs_to :mentioner
  belongs_to :mentionable, polymorphic: true
end

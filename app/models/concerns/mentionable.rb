# frozen_string_literal: true

module Mentionable
  extend ActiveSupport::Concern

  included do
    has_many :mentions, as: :mentionable, dependent: :destroy
  end
end

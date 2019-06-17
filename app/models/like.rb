class Like < ApplicationRecord
  # Associations
  belongs_to :user
  belongs_to :likable, counter_cache: true, polymorphic: true
end

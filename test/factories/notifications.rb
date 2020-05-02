# frozen_string_literal: true

FactoryBot.define do
  factory :notification do
    association :recipient, factory: :user, strategy: :create
    association :actor, factory: :user, strategy: :create
    association :notifiable, factory: :comment
    association :notifier, factory: :comment
  end
end

# frozen_string_literal: true

FactoryBot.define do
  factory :notification do
    action { 'commented' }
    association :recipient, factory: :user, strategy: :create
    association :actor, factory: :user, strategy: :create
    association :notifiable, factory: :comment
  end
end

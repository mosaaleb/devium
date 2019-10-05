# frozen_string_literal: true

FactoryBot.define do
  factory :friendship do
    association :user, strategy: :create
    association :friend, factory: :user, strategy: :create
  end
end

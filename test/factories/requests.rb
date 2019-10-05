# frozen_string_literal: true

FactoryBot.define do
  factory :request do
    association :sender, factory: :user, strategy: :create
    association :receiver, factory: :user, strategy: :create
  end
end

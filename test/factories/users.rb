# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    password { '123456' }
    sequence(:username) { |n| "newperson#{n}" }
    sequence(:email) { |n| "newperson#{n}@example.com" }
    association :profile, strategy: :build
  end
end

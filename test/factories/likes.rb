# frozen_string_literal: true

FactoryBot.define do
  factory :like do
    for_post

    trait :for_post do
      association :likable, factory: :post
    end

    trait :for_comment do
      association :likable, factory: :comment
    end

    association :user, strategy: :build
  end
end

# frozen_string_literal: true

FactoryBot.define do
  factory :mention do
    for_post

    association :mentioned, factory: :user
    association :mentioner, factory: :user

    trait :for_post do
      association :mentionable, factory: :post
    end

    trait :for_comment do
      association :mentionable, factory: :comment
    end
  end
end

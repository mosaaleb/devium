# frozen_string_literal: true

FactoryBot.define do
  factory :post do
    post_content { 'Just a post' }
    association :user, strategy: :create
  end
end

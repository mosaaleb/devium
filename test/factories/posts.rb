# frozen_string_literal: true

FactoryBot.define do
  factory :post do
    post_content { 'I am the one who knocks!' }
    association :user, strategy: :create
  end
end

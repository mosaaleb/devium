# frozen_string_literal: true

FactoryBot.define do
  factory :comment do
    comment_content { 'I am the first comment on this site' }
    association :user, strategy: :create
    association :post, strategy: :create
  end
end

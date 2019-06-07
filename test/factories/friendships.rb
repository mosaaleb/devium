FactoryBot.define do
  factory :friendship do
    association :user, strategy: :create
    association :friend, factory: :user, strategy: :create
  end
end

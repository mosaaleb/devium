FactoryBot.define do
  factory :profile do
    sequence(:first_name) { |n| "first#{n}" }
    sequence(:last_name) { |n| "last#{n}" }
  end
end

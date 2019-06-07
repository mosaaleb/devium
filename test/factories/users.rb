FactoryBot.define do
  factory :user do
    password { '123456' }
    sequence(:username) { |n| "newperson#{n}" }
    sequence(:email) { |n| "newperson#{n}@example.com" }
  end
end

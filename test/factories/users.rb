FactoryBot.define do
  factory :user do
    username { 'newperson' }
    email { 'newperson@example.com' }
    password { '123456' }
  end
end

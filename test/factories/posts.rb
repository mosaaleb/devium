FactoryBot.define do
  factory :post do
    post_content { 'the first post of this website' }
    association :user, strategy: :create
  end
end

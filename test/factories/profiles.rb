FactoryBot.define do
  factory :profile do
    date_of_birth { Date.new(2001,2,3) }
    gender { 'male' }
  end
end

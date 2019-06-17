FactoryBot.define do
  factory :profile do
    first_name { 'person' }
    last_name { 'personfather' }
    date_of_birth { Date.new(2001,2,3) }
    gender { 'male' }
  end
end

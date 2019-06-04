FactoryBot.define do
  factory :profile do
    first_name { 'person' }
    last_name { 'personfather' }
    gender { 'male' }
    date_of_birth { Date.new(2001,2,3) }
  end
end

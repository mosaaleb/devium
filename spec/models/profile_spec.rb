require 'rails_helper'

RSpec.describe Profile, type: :model do
  let(:user) { build :user }
  let(:profile) { build :profile}

  describe 'Validations' do
    context 'date of birth' do
      it 'is valid if date is present' do
        profile.valid?
        expect(profile.errors[:date_of_birth]).to be_blank
      end

      it 'is invalid if date is absent' do
        profile.date_of_birth = ''
        profile.save
        expect(profile.errors[:date_of_birth]).to include("can't be blank")
      end

      it 'is valid when age is >= 13' do
        profile.date_of_birth = Date.new(2001, 2, 3)
        profile.valid?
        expect(profile.errors[:date_of_birth]).to be_blank
      end

      it 'is not valid when age is < 13' do
        profile.date_of_birth = Date.new(2014, 2, 3)
        profile.valid?
        expect(profile.errors[:date_of_birth])
          .to include('You are ineligible to register for devmedium')
      end

      it "is not valid with a date in the future" do
        profile.date_of_birth = Date.new(4515, 02, 28)
        expect(profile).to_not be_valid
      end
    end

    context 'gender' do
      it 'is either male or female' do
        expect(profile.gender).to eq('male').or(eq('female')).or(eq('anything'))
      end
    end

  end
end

# t.string "first_name"
# t.string "last_name"
# t.string "gender" => male or female
# t.date "date_of_birth"=> can't be afte minimum age for site registeration
# t.text "about_me"
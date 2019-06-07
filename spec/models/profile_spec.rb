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
      it 'is female when set to 0' do
        profile.gender = 0
        expect(profile.gender).to eq('female')
      end

      it 'is male when set to 1' do
        profile.gender = 1
        expect(profile.gender).to eq('male')
      end

      it 'is valid if User chooses male or female' do
        profile.gender = 1
        profile.valid?
        expect(profile.errors[:gender]).to be_blank
      end

      it 'is invalid if User does not choose male or female' do   
        profile.gender = nil
        profile.valid?
        expect(profile.errors[:gender]).to include("can't be blank")
      end
    end

    context 'about_me' do
      it 'is valid with <= 400 characters' do
        profile.about_me = 'a' * 399
        profile.valid?
        expect(profile.errors[:about_me]).to be_blank
      end

      it 'is invalid if more than 140 characters' do
        profile.about_me = 'a' * 401
        profile.valid?
        expect(profile.errors[:about_me])
          .to include('is too long (maximum is 400 characters)')
      end
    end

  end
end
require 'rails_helper'

RSpec.describe Profile, type: :model do
  let(:user) { build :user }
  let(:profile) { build :profile}

  describe 'Validations' do
    context 'when date is present' do
      it 'is valid' do
        profile.valid?
        expect(profile.errors[:date_of_birth]).to be_blank
      end
    end

    context 'when date is absent' do
      it 'is invalid' do
        profile.date_of_birth = ''
        profile.save
        expect(profile.errors[:date_of_birth]).to include("can't be blank")
      end
    end

    context 'when age is >= 13' do
      it 'is valid' do
        profile.date_of_birth = Date.new(2001, 2, 3)
        profile.valid?
        expect(profile.errors[:date_of_birth]).to be_blank
      end
    end

    context 'when age is < 13' do
      it 'is not valid' do
        profile.date_of_birth = Date.new(2014, 2, 3)
        profile.valid?
        expect(profile.errors[:date_of_birth])
        .to include('You are ineligible to register for devmedium')
      end
    end

    context 'when date is in the future' do
      it "is invalid" do
        profile.date_of_birth = Date.new(4515, 02, 28)
        expect(profile).to_not be_valid
      end
    end


    context 'when set to 0' do
      it 'is female' do
        profile.gender = 0
        expect(profile.gender).to eq('female')
      end
    end

    context 'when set to 1' do
      it 'is male' do
        profile.gender = 1
        expect(profile.gender).to eq('male')
      end
    end

    context 'when user chooses male or female' do
      it 'is valid' do
        profile.gender = 1
        profile.valid?
        expect(profile.errors[:gender]).to be_blank
      end
    end

    context 'when user chooses neither male or female' do
      it 'is invalid ' do   
        profile.gender = nil
        profile.valid?
        expect(profile.errors[:gender]).to include("can't be blank")
      end
    end

    context 'when about_me has <= 400 characters' do
      it 'is valid' do
        profile.about_me = 'a' * 399
        profile.valid?
        expect(profile.errors[:about_me]).to be_blank
      end
    end

    context 'when about_me has > 400 characters' do
      it 'is invalid if more than 140 characters' do
        profile.about_me = 'a' * 401
        profile.valid?
        expect(profile.errors[:about_me])
          .to include('is too long (maximum is 400 characters)')
      end
    end

  end
  
  describe 'Associations' do
    context 'when user is deleted' do
      it 'is depedent on user deletion' do
        user
        user.destroy
        expect(Profile.count).to be 0
      end
    end
  end
   
end

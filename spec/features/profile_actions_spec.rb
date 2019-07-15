require 'rails_helper'

RSpec.feature "ProfileActions", type: :feature do
  let(:user) { create :user }

  scenario 'show user profile page successfully' do
    feature_sign_in(user.email, user.password)
    visit user_profile_path(user)

    expect(page).to have_content(user.fullname)
  end

  scenario 'edit user information successfully' do
    feature_sign_in(user.email, user.password)
    visit user_profile_path(user)

    click_on 'Edit Profile'
    fill_in 'First Name', with: 'MyNewFirstname'
    fill_in 'Last Name', with: 'MyNewLastname'
    click_on 'Update Profile'

    expect(page).to have_content('Profile updated successfully')

    visit user_profile_path(user)
    expect(page).to have_content('MyNewFirstname MyNewLastname')
  end
end

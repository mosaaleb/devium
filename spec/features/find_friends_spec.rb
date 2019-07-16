require 'rails_helper'

RSpec.feature "FindFriends", type: :feature do
  let(:current_user) { create :user }
  let!(:user1) { create :user }
  let!(:user2) { create :user }


  before(:example) do
    feature_sign_in(current_user.email, current_user.password)
    visit all_users_path
  end

  scenario 'list all available users except the current user' do
    expect(page).to have_css('.discover')

    within('.discover') do
      expect(page).to have_content(user1.fullname)
      expect(page).to have_content(user2.fullname)
    end
  end

  scenario 'does not list the current_user himself' do
    within('.discover') do
      expect(page).not_to have_content(current_user.fullname)
    end
  end
end

require 'rails_helper'

RSpec.feature "FriendshipActions", type: :feature do
  let(:user) { create :user }
  let(:friendship) { create :friendship }

  context 'when user has no friends' do
    scenario 'show no friends page' do
      feature_sign_in(user.email, user.password)
      visit friends_user_path(user.username)

      expect(page).to have_content("#{user.fullname} has no friends yet!")
    end
  end

  context 'when user has friends' do
    before do
      feature_sign_in(friendship.user.email, friendship.user.password)
      visit friends_user_path(friendship.user.username)
    end

    scenario 'show all friends succussfully' do

      expect(page).to have_content(friendship.friend.fullname)
    end

    scenario 'delete friendship' do
      click_on 'Remove Friend'

      expect(page).to have_content('Friend Removed')
    end
  end

end

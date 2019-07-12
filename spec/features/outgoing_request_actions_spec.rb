require 'rails_helper'

RSpec.feature "OutgoingRequestActions", type: :feature do
  let(:request1) { create :request }
  let(:user) { create :user }

  before do
    feature_sign_in(request1.sender.email, request1.sender.password)
    visit user_profile_path(user)
    click_on "Send Request"
  end

  scenario 'sends a request successfully' do
    expect(page).to have_content("Request Sent")
  end

  scenario 'cancels a request successfully' do
    click_on "Cancel Request"
    expect(page).to have_content("Request Cancelled")
  end

  scenario 'shows the sent requests' do
    visit sent_requests_path
    expect(page).to have_content(user.username)
  end
end

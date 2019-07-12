require 'rails_helper'

RSpec.feature "ReceviedRequestActions", type: :feature do
  let(:friendship_request) { create :request }

  before do
    feature_sign_in(friendship_request.receiver.email, friendship_request.receiver.password)
    visit received_requests_path
  end

  scenario 'show all requests successfully' do
    expect(page).to have_content(friendship_request.sender.fullname)
  end

  scenario 'accepts requests successfully' do
    click_on 'Accept'

    expect(page).to have_content('Friend Added')
  end

  scenario 'rejects requests successfully' do
    click_on 'Reject'

    expect(page).to have_content('Request Rejected')
  end

end

require 'rails_helper'

RSpec.feature "NewsfeedActions", type: :feature do
  let(:user) { create :user }

  before do
    feature_sign_in(user.email, user.password)
  end

  scenario 'show mini profile successfully' do
    expect(page).to have_css('.mini-profile')
  end

  scenario 'show newsfeed' do
    expect(page).to have_css('.newsfeed')
  end

end

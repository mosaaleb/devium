# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'UsersActions', type: :feature do
  let(:user) { create :user }

  before do
    feature_sign_in(user.email, user.password)
  end

  scenario 'shows all users' do
    click_on 'Find friends'

    expect(page).to have_content(user.fullname)
  end
end

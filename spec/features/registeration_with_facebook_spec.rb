require 'rails_helper'

RSpec.feature "RegisterationWithFacebooks", type: :feature do

  it 'can sign in user with facebook account' do
    visit root_path
    expect(page).to have_content("Sign in with Facebook")
    sign_in_with_facebook
    expect(page).to have_content('firstname lastname')
  end

  it 'has facebook image as profile image' do
    visit root_path
    sign_in_with_facebook
    expect(page).to have_css("img[src='http://link.to']")
  end

end

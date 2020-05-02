# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'RegisterationWithFacebooks', type: :feature do
  before do
    visit root_path
  end

  context 'when user is on sign in page' do
    it 'have sign in with facebook button' do
      expect(page).to have_content('Sign in with Facebook')
    end
  end

  context 'when user clicks on sign in with facebook' do
    before do
      sign_in_with_facebook
    end

    it 'logged in user first and last name appear after logging' do
      expect(page).to have_content('Firstname Lastname')
    end

    it 'has facebook image as profile image' do
      expect(page).to have_css("img[src='http://link.to']")
    end
  end
end

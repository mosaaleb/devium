# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'PostActions', type: :feature do
  let(:post1) { create :post }

  before do
    feature_sign_in(post1.user.email, post1.user.password)
    fill_in "What's happening?", with: post1.post_content
    click_on 'Publish'
  end

  scenario 'adds a post' do
    fill_in "What's happening?", with: 'First test post'
    click_on 'Publish'
    expect(page).to have_content('First test post')
  end

  scenario 'edits and updates a post' do
    click_link('Edit', href: edit_post_path(post1))
    fill_in "What's happening?", with: 'Updated post'
    click_on 'Publish'
    expect(page).to have_content('Updated post')
  end

  scenario 'deletes a post' do
    click_link('Delete', href: post_path(post1))
    expect(page).to have_content('Post deleted')
  end
end

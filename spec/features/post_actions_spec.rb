# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'PostActions', type: :feature do
  let(:post1) { create :post }

  before do
    feature_sign_in(post1.user.email, post1.user.password)
    fill_in "What's happening?", with: post1.post_content
    click_on 'Publish'
  end

  context 'when adding a post', js: true do
    it 'adds a post when post is valid' do
      fill_in 'post[post_content]', with: 'First test post'
      click_on 'Publish'
      expect(page).to have_content('First test post')
    end

    it 'alert post errors when post is not valid' do
      fill_in 'post[post_content]', with: ''
      click_on 'Publish'
      expect(page).to have_content("Post content can't be blank")
    end
  end

  it 'edits and updates a post' do
    click_link('Edit', href: edit_post_path(post1))
    fill_in "What's happening?", with: 'Updated post'
    click_on 'Publish'
    expect(page).to have_content('Updated post')
  end

  it 'deletes a post' do
    click_link('Delete', href: post_path(post1))
    expect(page).to have_content('Post deleted')
  end
end

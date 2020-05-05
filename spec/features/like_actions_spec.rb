# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'LikeActions', type: :feature do
  let(:current_user) { create :user }
  let(:comment) { create :comment }

  before do
    feature_sign_in(current_user.email, current_user.password)
    fill_in "What's happening?", with: comment.post.post_content
    click_on 'Publish'
    click_on 'Add Comment'
    fill_in 'comment[comment_content]', with: 'Just a comment!'
    click_on 'Comment'
  end

  context 'when it is a post' do
    it 'likes the post', js: true do
      within '.post-likes' do
        click_link
      end
      expect(page).to have_css('.badge', text: '1')
    end

    it 'unlikes the post', js: true do
      within '.post-likes' do
        click_link
        click_link
      end
      expect(page).to have_css('.badge', text: '0')
    end
  end

  context 'when it is a comment' do
    it 'likes the comment', js: true do
      within '.comment-likes' do
        click_link
      end
      expect(page).to have_content('1')
    end

    it 'unlikes the comment', js: true do
      within '.comment-likes' do
        click_link
        click_link
      end
      expect(page).to have_css('.badge', text: '0')
    end
  end
end

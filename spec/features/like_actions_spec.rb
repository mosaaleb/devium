require 'rails_helper'

RSpec.feature "LikeActions", type: :feature do
  let(:comment) { create :comment }

  before do
    feature_sign_in(comment.user.email, comment.user.password)
    fill_in "What's happening?", with: comment.post.post_content
    click_on 'Publish'
    fill_in 'Comment on this post.', with: 'First test comment'
    click_on 'Comment'
  end

  context "when it is a post" do
    scenario 'likes the post' do
      within ".post-likes" do
        click_link
      end
      expect(page).to have_css(".badge", text: "1")
    end

    scenario 'unlikes the post' do
      within ".post-likes" do
        click_link
        click_link
      end
      expect(page).to have_css(".badge", text: "0")
    end
  end

  context "when it is a comment" do
    scenario 'likes the comment' do
      within ".comment-likes" do
        click_link
      end
      expect(page).to have_content("1")
    end

    scenario 'unlikes the comment' do
      within ".comment-likes" do
        click_link
        click_link
      end
      expect(page).to have_css(".badge", text: "0")
    end
  end
end

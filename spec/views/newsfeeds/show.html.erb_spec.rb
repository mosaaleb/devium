# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'newsfeeds/show.html.erb', type: :view do
  let(:user) { create :user }
  let(:timeline_posts) { create_list(:post, 5) }

  before do
    sign_in user
    assign(:post, Post.new)
    assign(:current_user, user)
    assign(:timeline, instance_double(Timeline, posts: timeline_posts))
    render
  end

  it 'renders a form for creating a posts' do
    expect(rendered).to have_selector('.form-new-post form')
  end

  it 'renders posts partial' do
    timeline_posts.each do |post|
      expect(rendered).to include post.post_content
    end
  end

  it 'renders likes box class' do
    expect(rendered).to have_selector('.likes-box', count: timeline_posts.size)
  end

  it 'renders a like button for posts' do
    expect(rendered)
      .to have_selector('.likes-box a', count: timeline_posts.size)
  end

  it 'renders post likes count' do
    timeline_posts.each do |post|
      expect(rendered).to have_selector('.likes-box', text: post.likes_count)
    end
  end

  it 'renders a form for new comment' do
    expect(rendered)
      .to have_selector('.form-new-comment form', count: timeline_posts.size)
  end

  it 'renders comments for every post' do
    expect(rendered).to have_selector('.post-comments')
  end
end


require 'rails_helper'

RSpec.describe "newsfeeds/show.html.erb", type: :view do
  let(:post1) { create :post }
  let(:post2) { create :post }
  let(:user) { create :user }

  before do
    sign_in user
    assign(:post, Post.new)
    assign(:timeline_posts, [post1, post2])
    assign(:current_user, user)
    # assign(:posts, [double(Post, post_content: 'first post', user_id: 1), double(Post, post_content: 'second post', user_id: 2)])
  end

  it 'renders a form for creating a posts' do
    render

    expect(rendered).to have_selector('.form-new-post form')
  end

  it 'renders posts partial' do
    render 

    expect(rendered).to include post1.post_content
    expect(rendered).to include post2.post_content
  end

  it 'renders likesbox class' do
    render

    expect(rendered).to have_selector('.likes-box', count: 2)
  end

  it 'renders a like button for posts' do
    render 

    expect(rendered).to have_selector('.likes-box a', count: 2)
  end

  it 'renders post likes count' do
    render

    expect(rendered).to have_selector('.likes-box', text: post1.likes_count)
    expect(rendered).to have_selector('.likes-box', text: post2.likes_count)
  end
  
  it 'renders a form for new comment' do
    render

    expect(rendered).to have_selector('.form-new-comment form', count: 2)
  end

  it 'renders comments for every post' do
    render

    expect(rendered).to have_selector('.post-comments')
  end
end
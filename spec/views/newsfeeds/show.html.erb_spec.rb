require 'rails_helper'

RSpec.describe "newsfeeds/show.html.erb", type: :view do
  let(:post1) { create :post}
  let(:post2) { create :post }

  before do
    assign(:post, Post.new)
    assign(:posts, [post1, post2])
    # assign(:posts, [double(Post, post_content: 'first post', user_id: 1), double(Post, post_content: 'second post', user_id: 2)])
  end

  it 'contain Newsfeed word' do
    render

    expect(rendered).to match('<h1>Newsfeed</h1>')
    expect(rendered).to include('Newsfeed')
    expect(rendered).to have_selector('h1', text: 'Newsfeed', count: 1)
  end

  it 'renders a form for creating a posts' do
    render

    expect(rendered).to have_selector('form')
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

  it 'renders a like button' do
    render 

    expect(rendered).to have_selector('form.button_to', count: 2)
  end

  it 'renders post likes count' do
    render

    expect(rendered).to have_selector('p', text: post1.likes_count)
    expect(rendered).to have_selector('p', text: post2.likes_count)
  end
  
  # it 'displays a form for neis not an ActiveModel-compatible objecw post' do

  #   render

  #   rendered.should contain("slicer")
  #   rendered.should contain("dicer")
  # end
end

# Notes

## render 'posts', model: post
## expect(rendered).to have_selector('a', :href => '/issues/new')

# assign(:widget, Widget.new)
# render

## assign(:events, [double(Post), double(Post)])
## expect(view).to render_template(:partial => "_post", :count => 2)

## https://relishapp.com/rspec/rspec-rails/docs/view-specs/view-spec#view-specs-can-stub-a-helper-method
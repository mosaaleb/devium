require 'rails_helper'

RSpec.describe "posts/show.html.erb", type: :view do
  let(:post) { create :post }
  let(:user) { create :user }

  before do
    assign(:post, post)
  end

  it 'renders post partial' do
    render 

    expect(rendered).to include post.post_content
  end

  it 'renders edit button for authorized logged users' do
    sign_in post.user

    render

    expect(rendered).to have_selector('.post-edit-button a')
  end

  it 'does not render edit button for logged out users' do
    render

    expect(rendered).not_to have_selector('.post-edit-button a')
  end

  it 'does not render edit button for unauthorized users' do
    sign_in user

    render

    expect(rendered).not_to have_selector('.post-edit-button a')
  end

  it 'renders delete button for authorized logged users' do
    sign_in post.user

    render

    expect(rendered).to have_selector('.post-delete-button a')
  end

  it 'does not render delete button for logged out users' do
    render

    expect(rendered).not_to have_selector('.post-delete-button a')
  end

  it 'does not render delete button for unauthorized users' do
    sign_in user

    render

    expect(rendered).not_to have_selector('.post-delete-button a')
  end
end

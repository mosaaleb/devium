require 'rails_helper'

RSpec.describe "posts/edit.html.erb", type: :view do
  it 'has form for editing the post' do
    assign(:post, Post.new)

    render

    expect(rendered).to have_selector('.form-edit-post form')
  end
end

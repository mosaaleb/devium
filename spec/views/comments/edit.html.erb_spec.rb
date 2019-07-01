require 'rails_helper'

RSpec.describe "comments/edit.html.erb", type: :view do
  let(:comment) { create :comment }

  before do
    assign(:comment, comment)
  end

  it 'has css selector comments-edit-form' do
    render

    expect(rendered).to have_selector('.comments-edit-form')
  end
  
  it 'renders comment edit form' do
    render

    expect(rendered).to have_selector('.comments-edit-form form')
  end
end

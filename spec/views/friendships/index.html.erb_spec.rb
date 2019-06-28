require 'rails_helper'

RSpec.describe "friendships/index.html.erb", type: :view do
  let(:user) { create :user }
  let(:friend1) { create :user }
  let(:friend2) { create :user }

  before do
    assign(:user, user)
    assign(:friends, [friend1, friend2])
  end

  it 'have selector friends class' do
    render

    expect(rendered).to have_selector('div.friends-list')
  end

  it 'renders friends' do
    render

    expect(rendered).to have_selector('.mini-profile-card', count: 2)
  end

end
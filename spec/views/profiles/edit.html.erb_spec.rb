require 'rails_helper'

RSpec.describe "profiles/edit.html.erb", type: :view do
  let(:user) { create :user }

  before do
    assign(:user, user)
    assign(:profile, user.profile)
  end

  it 'renders a form for editing profile information' do
    render

    expect(rendered).to have_selector('.form-edit-profile form')
  end

  it 'renders text field with placeholder First name' do
    render

    expect(rendered).to have_selector("input[placeholder='First Name']")
  end

  it 'renders text field with placeholder Last name' do
    render

    expect(rendered).to have_selector("input[placeholder='Last Name']")
  end
  it 'renders two radio buttons with value male and female' do
    render

    expect(rendered).to have_selector("input[type=radio]", count: 2)
  end

  it 'renders text area field' do
    render

    expect(rendered).to have_selector("textarea#profile_about_me")
  end

  it 'renders date field' do
    render

    expect(rendered).to have_selector("input[type=date]")
  end

  it 'renders submit button' do
    render

    expect(rendered).to have_selector('input[type=submit]')
  end
end

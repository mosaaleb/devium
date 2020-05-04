# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'profiles/show.html.erb', type: :view do
  let(:user) { create :user }
  let(:current_user) { create :user }
  let(:timeline_posts) { create_list(:post, 5, user: user) }

  before do
    user_timeline = instance_double(Timeline)
    allow(user_timeline)
      .to receive_messages(posts: timeline_posts,
                           to_partial_path: 'timelines/timeline')
    assign(:user, user)
    assign(:timeline, user_timeline)
  end

  it "renders user's username" do
    render

    expect(rendered).to include(user.username)
  end

  it "renders user's posts" do
    render

    expect(rendered).to have_selector('.post_box', count: timeline_posts.size)
  end

  it 'renders the request button' do
    render

    expect(rendered)
      .to have_selector('.friendship_button a', text: 'Send Request')
  end

  it 'shows the number of friends' do
    current_user.friendships.create friend: user
    render

    expect(rendered)
      .to have_selector('.friends-details', text: user.friendships_count.to_s)
  end

  it 'shows link to edit profile' do
    sign_in user
    render

    expect(rendered)
      .to have_selector('.edit-profile-button a', text: 'Edit Profile')
  end

  it 'shows bio information' do
    user.profile.about_me = 'I am the bio!'
    render

    expect(rendered).to have_selector('.about-me', text: 'I am the bio!')
  end

  it 'shows date of birth' do
    user.profile.date_of_birth = Date.new(2002, 12, 1)

    render

    expect(rendered)
      .to have_selector('.profile-details .date-of-birth',
                        text: 'December 01, 2002')
  end

  it 'shows full name' do
    user.profile.first_name = 'Testme'
    user.profile.last_name = 'Ifyoulike'
    render

    expect(rendered).to have_selector('.full-name', text: 'Testme Ifyoulike')
  end

  it 'shows gender' do
    user.profile.gender = 'male'
    render

    expect(rendered).to have_selector('.profile-details .gender',
                                      text: user.profile.gender.capitalize.to_s)
  end

  context 'when there is signed in user' do
    before do
      sign_in current_user
    end

    it 'render remove friend button if both users are already friends' do
      current_user.friendships.create friend: user
      render

      expect(rendered)
        .to have_selector('.friendship_button a', text: 'Remove Friend')
    end

    it 'render cancel request button if the user has already sent a request' do
      current_user.outgoing_requests.create receiver: user
      render

      expect(rendered)
        .to have_selector('.friendship_button a', text: 'Cancel Request')
    end

    it 'does not render request btn if profile belongs to the same user' do
      sign_in user
      render

      expect(rendered).not_to have_selector('.friendship_button a')
    end
  end
end


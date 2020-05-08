# frozen_string_literal: true

require 'rails_helper'
require 'models/concerns/mentionable_spec'

RSpec.describe Comment, type: :model do
  let(:followed_post) { create :post }
  let(:aida) { create :user }
  let(:john) { create :user }

  it_behaves_like 'mentionable'

  describe 'Validations' do
    it { is_expected.to validate_presence_of(:comment_content) }
    it { is_expected.to validate_length_of(:comment_content).is_at_most(200) }
  end

  describe 'Association' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:post) }
    it { is_expected.to have_many(:likes) }
    it { is_expected.to have_many(:notifications) }
  end

  describe 'creating notifications' do
    context 'when created' do
      before do
        john.comments.create(comment_content: 'Just a comment',
                             post_id: followed_post.id)
      end

      it 'creates notification for commented post original author' do
        expect(Notification.where(recipient: followed_post.user))
          .not_to be_empty
      end

      it 'creates notification for commented post subscribers' do
        aida.comments.create(comment_content: 'I am a comment',
                             post_id: followed_post.id)
        expect(Notification.count).to be 3
      end

      it 'does not create a notification for comment author' do
        expect(Notification.where(recipient: john)).to be_empty
      end
    end
  end
end

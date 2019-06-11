require 'rails_helper'

RSpec.describe Request, type: :model do
  let(:sender) { create :user }
  let(:receiver) { create :user }

  describe 'Validation' do
    context 'user requests' do
      it 'is invalid when request already exists' do
        sender.outgoing_requests.create receiver: receiver
        request = sender.outgoing_requests.create receiver: receiver
        expect(request.errors[:sender_id]).to include("has already been taken")
      end

      it 'is invalid if the users are already friends' do
        sender.friendships.create friend: receiver
        request = sender.outgoing_requests.create receiver: receiver
        expect(request.errors[:sender_id]).to include(/already friends/)
      end

    end
  end

end

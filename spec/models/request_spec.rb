# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Request, type: :model do
  let(:sender) { create :user }
  let(:receiver) { create :user }
  let(:request) { create :request }

  describe 'DB validations' do
    context 'when request already exists' do
      before do
        sender.outgoing_requests.create(receiver: receiver)
      end

      it 'is invalid when a sender sends anther request to receiver' do
        request = sender.outgoing_requests.build receiver: receiver
        expect { request.save validate: false }
          .to raise_error(ActiveRecord::RecordNotUnique)
      end

      it 'is invalid when a receiver sends a duplicated request to sender' do
        inverse_request = receiver.outgoing_requests.build receiver: sender
        expect { inverse_request.save validate: false }
          .to raise_error(ActiveRecord::RecordNotUnique)
      end
    end
  end

  describe 'Validation' do
    context 'when request already exists' do
      before do
        sender.outgoing_requests.create receiver: receiver
      end

      it 'is invalid for duplicated requests' do
        request = sender.outgoing_requests.create receiver: receiver
        expect(request.errors[:sender_id]).to include('request already sent')
      end

      it 'is invalid for duplicated inverse requests' do
        inverse_request = receiver.outgoing_requests.create receiver: sender
        expect(inverse_request.errors[:sender_id])
          .to include('request already sent')
      end
    end

    context 'when user sends friend requst to himself' do
      it 'is invalid' do
        request = sender.outgoing_requests.create receiver: sender

        expect(request.errors[:sender_id])
          .to include(/can't send a request to yourself/)
      end
    end

    context 'when users are already friends' do
      before do
        sender.friendships.create friend: receiver
      end

      it 'is invalid for direct relationship' do
        request = sender.outgoing_requests.create receiver: receiver
        expect(request.errors[:sender_id]).to include(/already friends/)
      end

      it 'is invalid for inverse relationship' do
        inverse_request = receiver.outgoing_requests.create receiver: sender
        expect(inverse_request.errors[:sender_id]).to include(/already friends/)
      end
    end
  end

  describe 'Associations' do
    context 'when user is destroyed' do
      it 'is expected to destroy dependent requests' do
        request
        expect { request.receiver.destroy }
          .to change(described_class, :count).by(-1)
      end
    end
  end
end

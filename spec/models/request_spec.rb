require 'rails_helper'

RSpec.describe Request, type: :model do
  let(:sender) { create :user }
  let(:receiver) { create :user }
  let(:request) { create :request }

  describe 'DB validations' do
    context 'when request already exists' do
      it 'is invalid' do
        sender.outgoing_requests.create receiver: receiver

        request = sender.outgoing_requests.build receiver: receiver
        expect { request.save validate: false}.to raise_error(ActiveRecord::RecordNotUnique)

        inverse_request = receiver.outgoing_requests.build receiver: sender
        expect { inverse_request.save validate: false}.to raise_error(ActiveRecord::RecordNotUnique)
      end
    end
  end

  describe 'Validation' do
    context 'when request already exists' do
      it 'is invalid' do
        sender.outgoing_requests.create receiver: receiver

        request = sender.outgoing_requests.create receiver: receiver
        expect(request.errors[:sender_id]).to include('request already sent')

        inverse_request = receiver.outgoing_requests.create receiver: sender
        expect(inverse_request.errors[:sender_id]).to include('request already sent')
      end
    end

    context 'when user sends friend requst to himself' do
      it 'is invalid' do
        request = sender.outgoing_requests.create receiver: sender

        expect(request.errors[:sender_id]).to include(/can't send a request to yourself/)
      end
    end

    context 'when users are already friends' do
      it 'is invalid' do
        sender.friendships.create friend: receiver

        request = sender.outgoing_requests.create receiver: receiver
        expect(request.errors[:sender_id]).to include(/already friends/)

        inverse_request = receiver.outgoing_requests.create receiver: sender
        expect(inverse_request.errors[:sender_id]).to include(/already friends/)
      end
    end
  end

  describe 'Associations' do
    context 'when user is destroyed' do      
      it 'is expected to destroy dependent requests' do
        request
        expect { request.receiver.destroy }.to change { Request.count }.by(-1)
      end
    end
  end
end

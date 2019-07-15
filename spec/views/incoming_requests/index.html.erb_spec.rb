require 'rails_helper'

RSpec.describe "incoming_requests/index.html.erb", type: :view do
  let(:request1) { create :request }
  let(:request2) { create :request }
  
  let(:receiver) { create :user }

  before do
    assign(:receiver, receiver)
    assign(:incoming_requests, [request1, request2])
  end

  it 'render all incoming friendship requests' do 
    render

    expect(rendered).to have_selector('.incoming-requests')
  end

  it 'render requests' do
    render

    expect(rendered).to have_selector('.incoming-requests .request-box', count: 2)
  end

  it 'renders accept or reject button' do
    render

    expect(rendered).to have_selector('.friendships-buttons .accept-button')
    expect(rendered).to have_selector('.friendships-buttons .reject-button')
  end
end

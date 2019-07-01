require 'rails_helper'

RSpec.describe "outgoing_requests/index.html.erb", type: :view do
  let(:request1) { create :request }
  let(:request2) { create :request }

  before do
    assign(:outgoing_requests, [request1, request2])
  end

  it 'render all outgoing friendship requests' do 
    render

    expect(rendered).to have_selector('.outgoing-requests')
  end

  it 'render requests' do
    render

    expect(rendered).to have_selector('.outgoing-requests .request-box', count: 2)
  end

  it 'renders cancel request button' do
    render

    expect(rendered).to have_selector('.cancel-request-button')
  end
end

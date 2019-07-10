require 'rails_helper'

RSpec.describe "Newsfeeds", type: :request do
  describe "GET /" do
    let(:user)  { create :user }
    
    context 'when not logged in' do
      it "redirects to sign_in page" do
        get '/'
        
        expect(response.body).to include("login")
      end
    end
    
  end
end

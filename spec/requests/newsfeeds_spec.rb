require 'rails_helper'

RSpec.describe "Newsfeeds", type: :request do
  describe "GET /" do
    let(:user)  { create :user }
    
    context 'when not logged in' do
      it "redirects to sign_in page" do
        get '/'
        
        expect(response.body).to include("Log in")
      end
    end

    context 'when looged in' do
      it 'redirects to newsfeed page' do  
        sign_in user
        
        get '/'
        
        expect(response.body).to include("Newsfeed")
      end
    end

  end
end

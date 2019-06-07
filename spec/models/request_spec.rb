require 'rails_helper'

RSpec.describe Request, type: :model do
  let (:user) { build :user }

  describe 'associations' do
    it 'is destroyed when user is deleted' do
      user.build_request
      
    end
    
  end
end

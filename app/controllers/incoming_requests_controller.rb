class IncomingRequestsController < ApplicationController
  before_action :authenticate_user!
  
  def index
  end

  def destroy
    @request = current_user.incoming_requests.find_by(sender_id: params[:id])
    current_user.rejects_request(@request)
    redirect_back(fallback_location: root_path)
  end
end

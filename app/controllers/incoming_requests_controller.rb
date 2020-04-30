# frozen_string_literal: true

class IncomingRequestsController < ApplicationController
  before_action :authenticate_user!

  def index
    @incoming_requests = current_user.incoming_requests
  end

  def destroy
    @request = current_user.incoming_requests.find_by(sender_id: params[:id])
    current_user.rejects_request(@request)
    flash[:notice] = 'Request Rejected!'
    redirect_back(fallback_location: root_path)
  end
end

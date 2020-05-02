# frozen_string_literal: true

class OutgoingRequestsController < ApplicationController
  before_action :authenticate_user!

  def index
    @outgoing_requests = current_user.outgoing_requests
  end

  def create
    current_user.sends_request(receiver)
    flash[:notice] = 'Request Sent!'
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @request = current_user.outgoing_requests.find_by(receiver_id: receiver)
    current_user.unsend_request(@request)
    flash[:notice] = 'Request Cancelled!'
    redirect_back(fallback_location: root_path)
  end

  private

  def receiver
    @receiver ||= User.find(params[:id])
  end
end

# frozen_string_literal: true

class RequestsController < ApplicationController
  before_action :authenticate_user!

  def index; end

  def create
    @receiver = User.find(params[:id])
    current_user.sends_request(@receiver)
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @request = current_user.outgoing_requests.find_by(receiver_id: params[:id])
    current_user.unsend_request(@request)
    redirect_back(fallback_location: root_path)
  end
end

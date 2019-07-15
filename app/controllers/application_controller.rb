class ApplicationController < ActionController::Base
  def authorize_user(user)
    return if user == current_user
    flash[:alert] = 'You are not authorized!'
    redirect_back(fallback_location: root_path)
  end
end

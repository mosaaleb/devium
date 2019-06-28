class FriendshipsController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = User.find_by(username: params[:username])
    @friends = @user.all_friends
  end
  
  def create
    current_user.accepts_friendship(friend)
    redirect_to received_requests_user_path(current_user)
  end

  def destroy
    current_user.deletes_friendship(friend)
    redirect_to user_profile_path(friend)
  end

  private

  def friend
    User.find(params[:id])
  end
end

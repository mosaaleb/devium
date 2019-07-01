class FriendshipsController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = User.find_by(username: params[:username])
    @friends = @user.all_friends
  end
  
  def create
    current_user.accepts_friendship(friend)
    flash[:notice] = 'Friend Added!'
    redirect_to received_requests_path
  end

  def destroy
    current_user.deletes_friendship(friend)
    flash[:notice] = 'Friend Removed!'
    redirect_to user_profile_path(friend)
  end

  private

  def friend
    User.find(params[:id])
  end
end

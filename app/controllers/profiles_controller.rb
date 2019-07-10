# TODO: Find a way to redirect titlecased urls to their downcase counterparts
class ProfilesController < ApplicationController
  before_action :authenticate_user!, except: :show
  
  def show
    @user = User.find_by(username: params[:user_username])

    render html: 'User not found' and return unless @user

    @profile = @user.profile
    @posts = @user.posts
  end

  def edit
    user = User.find_by(username: params[:user_username])
    redirect_to user_profile_path(user) unless current_user == user

    @profile = current_user.profile
  end

  def update
    @profile = current_user.profile
    if @profile.update profile_params
      flash[:notice] = 'Profile updated successfully!'
      redirect_back(fallback_location: root_path)
    else
      render :edit
    end
  end

  private

  def profile_params
    params.require(:profile).permit(:date_of_birth, :first_name, :last_name, :gender, :about_me)
  end

end

class ProfilesController < ApplicationController
  before_action :authenticate_user!, except: :show
  
  def show
    @user = User.find_by(username: params[:user_username])
    @profile = @user.profile
  end

  def edit
    user = User.find_by(username: params[:user_username])
    redirect_to user_profile_path(user) unless current_user == user

    @profile = current_user.profile
  end

  def update
    @profile = current_user.profile
    if @profile.update profile_params
      flash[:success] = 'Profile updated successfully'
      redirect_to user_profile_path(current_user)
    else
      render :edit
    end
  end

  private

  def profile_params
    params.require(:profile).permit(:date_of_birth, :first_name, :last_name, :gender, :about_me)
  end

end

# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController

  def new
    @user = User.new
    @profile = @user.build_profile
  end

  def create
    @user = User.new sign_up_params
    if @user.valid? && @user.profile&.valid?
      @user.save
      flash[:success] = 'Account successfully created!'
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def sign_up_params
    params.require(:user).permit(:email, :username, :password, profile_attributes: [:date_of_birth, :gender])
  end

end

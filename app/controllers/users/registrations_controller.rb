# frozen_string_literal: true
class Users::RegistrationsController < Devise::RegistrationsController

  def new
    super { resource.build_profile }
  end

  protected

  def after_update_path_for(resource)
    request.referrer
  end

  def sign_up_params
    params.require(:user).permit(:email, :username, :password, profile_attributes: [:date_of_birth, :gender])
  end

end

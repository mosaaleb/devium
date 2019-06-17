# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController

  def new
    build_resource({})
    self.resource.profile = Profile.new
    respond_with self.resource
  end

  def create
    super
  end

  private

  def sign_up_params
    params.require(:user).permit(:email, :username, :password, profile_attributes: [:date_of_birth, :gender])
  end

end

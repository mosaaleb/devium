# frozen_string_literal: true

module ApplicationHelper
  def avatar(user, size)
    sizes = { x_small: 30, small: 45, medium: 80,
              large: 100, x_large: 130, profile: 300 }
    email_digest = Digest::MD5.hexdigest(user.email.downcase)
    gravatar_url = "//www.gravatar.com/avatar/#{email_digest}?&s=#{sizes[size]}"
    gravatar_url
  end

  def choose_avatar(user, size)
    return user.image_path if user.image_path

    avatar(user, size)
  end

  def entry_pages?
    controller_name.in? %w[sessions registrations]
  end

  def navbar
    render 'navbar' unless entry_pages?
  end

  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end
end

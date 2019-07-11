module ApplicationHelper
  
  def avatar(user, size)
    image_sizes = { x_small: 30, small: 45, medium: 80, large: 100, x_large: 130, profile: 300 }
    email_digest = Digest::MD5::hexdigest(user.email.downcase)
    gravatar_url = "//www.gravatar.com/avatar/#{email_digest}?&s=#{image_sizes[size]}"
    gravatar_url
  end

  def choose_avatar(user, size)
    if user.image_path
      return user.image_path
    else
      avatar(user, size)
    end
  end

  def show_navbar
    render 'navbar' if signed_in?
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

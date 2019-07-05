module ApplicationHelper

  def avatar(user, size)
    image_sizes = { x_small: 30, small: 40, medium: 50, large: 60, x_large: 70, profile: 300 }
    email_digest = Digest::MD5::hexdigest(user.email.downcase)
    gravatar_url = "//www.gravatar.com/avatar/#{email_digest}?&s=#{image_sizes[size]}"
    gravatar_url
  end

  def show_navbar
    render 'navbar' if signed_in?
  end
end

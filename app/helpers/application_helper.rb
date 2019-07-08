module ApplicationHelper

  def avatar(user, size)
    image_sizes = { x_small: 30, small: 45, medium: 80, large: 100, x_large: 130, profile: 300 }
    email_digest = Digest::MD5::hexdigest(user.email.downcase)
    gravatar_url = "//www.gravatar.com/avatar/#{email_digest}?&s=#{image_sizes[size]}"
    gravatar_url
  end

  # def show_flash_messages
  #   if flash[:notice]
  #       button_to type: "button", class: 'close', 'data-dismiss': 'alert' do
  #         "&times;".html_safe
  #         flash[:notice]
  #       end
  #   elsif flash[:alert]
  #     button_to type: "button", class: 'close', 'data-dismiss': 'alert' do
  #       flash[:alert]
  #     end
  #   end
  # end

  def show_navbar
    render 'navbar' if signed_in?
  end
end

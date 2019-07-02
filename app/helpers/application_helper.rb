module ApplicationHelper

  def avatar(user, size)
    image_sizes = { x_small: 30, small: 40, medium: 50, large: 60, x_large: 70}
    email_digest = Digest::MD5::hexdigest(user.email)
    #default_image = "#{root_url}images/like.png"
    # default_image = link_to image_tag('dislike.png')
    #default_image = 'https://www.gstatic.com/webp/gallery3/2.png'
    gravatar_url = "//www.gravatar.com/avatar/#{email_digest}?&s=#{image_sizes[size]}"
    image_tag gravatar_url, class: 'profile-image'
  end

end

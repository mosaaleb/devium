# frozen_string_literal: true

module LikesHelper
  def like_button(likable)
    return unless current_user

    if current_user.liked?(likable)
      link_to image_tag('dislike'),
              polymorphic_path([:dislike, likable], type: likable.class),
              method: :delete, remote: true
    else
      link_to image_tag('like'),
              polymorphic_path([:like, likable], type: likable.class),
              method: :post, remote: true
    end
  end
end

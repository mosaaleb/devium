module PostsHelper

  def like_post_button(post)
    case
    when current_user.nil?
      link_to 'Like', new_user_session_path
    when current_user.liked?(post)
      link_to image_tag('dislike.png'), post_dislike_path(post), method: :delete
    else
      link_to image_tag('like.png'), post_like_path(post), method: :post
    end
  end

end

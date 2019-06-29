module PostsHelper

  def like_post_button(post)
    case
    when current_user.nil?
      link_to 'Like', new_user_session_path
    when current_user.liked?(post)
      button_to 'Unlike', post_dislike_path(post), method: :delete
    else
      button_to 'Like', post_like_path(post)
    end
  end

end

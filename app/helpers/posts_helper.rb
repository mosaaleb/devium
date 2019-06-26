module PostsHelper
  
  def like_button(post)
    unless current_user.liked?(post)
      button_to 'Like', post_like_path(post)
    else
      button_to 'Unlike', post_dislike_path(post), method: :delete
    end
  end

end

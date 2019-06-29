module CommentsHelper
  
  def like_comment_button(comment)
    case
    when current_user.nil?
      link_to 'Like', new_user_session_path
    when current_user.liked?(comment)
      link_to image_tag('dislike.png'), comment_dislike_path(comment), method: :delete
    else
      link_to image_tag('like.png'), comment_like_path(comment), method: :post
    end
  end

end
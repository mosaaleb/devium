module CommentsHelper
  def like_comment_button(comment)
    case
      when current_user.nil?
        link_to 'Like', new_user_session_path
      when current_user.liked?(comment)
        button_to 'Unlike', comment_dislike_path(comment), method: :delete
      else
        button_to 'Like', comment_like_path(comment)
    end
  end
end
module CommentsHelper
  def like_button(comment)
    unless current_user.liked?(comment)
      button_to 'Like', comment_like_path(comment)
    else
      button_to 'Unlike', comment_dislike_path(comment), method: :delete
    end
  end
end
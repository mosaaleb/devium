# frozen_string_literal: true

module CommentsHelper
  def like_comment_button(comment)
    if current_user.nil?
      link_to 'Like', new_user_session_path
    elsif current_user.liked?(comment)
      link_to image_tag('dislike.png'), comment_dislike_path(comment), method: :delete
    else
      link_to image_tag('like.png'), comment_like_path(comment), method: :post
    end
  end

  def edit_button(comment)
    if current_user && current_user == comment.user
      link_to 'Edit', edit_comment_path(comment.id), class: 'edit-comment-button'
    end
  end

  def delete_button(comment)
    if current_user && current_user == comment.user
      link_to 'Delete', comment_path(comment.id), method: :delete, class: 'delete-comment-button'
    end
  end

  def show_dropdown_comment_button(comment)
    if edit_button(comment) && delete_button(comment)
      render 'posts/dropdown'
    end
  end
end

# frozen_string_literal: true

module CommentsHelper
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

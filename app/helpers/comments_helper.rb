# frozen_string_literal: true

module CommentsHelper
  def edit_button(comment)
    return unless current_user == comment.user

    link_to 'Edit', edit_comment_path(comment), class: 'edit-comment-button'
  end

  def delete_button(comment)
    return unless current_user == comment.user

    link_to 'Delete', comment_path(comment),
            method: :delete, class: 'delete-comment-button'
  end

  def show_dropdown_comment_button(comment)
    render 'posts/dropdown' if edit_button(comment) && delete_button(comment)
  end
end

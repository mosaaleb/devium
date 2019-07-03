# frozen_string_literal: true

module PostsHelper
  
  def like_post_button(post)
    if current_user.nil?
      link_to 'Like', new_user_session_path
    elsif current_user.liked?(post)
      link_to image_tag('dislike.png'), post_dislike_path(post), method: :delete
    else
      link_to image_tag('like.png'), post_like_path(post), method: :post
    end
  end

  def edit_post_button(post)
    if current_user && current_user == post.user
      link_to 'Edit', edit_post_path(post)
    end
  end

  def delete_post_button(post)
    if current_user && current_user == post.user
      link_to 'Delete', post_path(post), method: :delete
    end
  end

  def show_dropdown_post_button(post)
    if edit_post_button(post) && delete_post_button(post)
      render 'posts/dropdown'
    end
  end
end

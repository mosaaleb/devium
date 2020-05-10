# frozen_string_literal: true

module PostsHelper
  def edit_post_button(post)
    return unless current_user && current_user == post.user

    link_to 'Edit', edit_post_path(post)
  end

  def delete_post_button(post)
    return unless current_user && current_user == post.user

    link_to 'Delete', post_path(post), method: :delete, remote: true
  end

  def show_dropdown_post_button(post)
    return unless edit_post_button(post) && delete_post_button(post)

    render 'posts/dropdown'
  end

  def autolink(text)
    text
      .gsub(/#\w+/) { |x| link_to x, hashtag_path(x[1..-1]) }
      .gsub(/@\w+/) { |y| link_to y, user_profile_path(y[1..-1]) }
      .html_safe
  end
end

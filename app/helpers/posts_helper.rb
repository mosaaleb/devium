# frozen_string_literal: true

module PostsHelper
  def edit_post_button(post)
    return unless current_user && current_user == post.user

    link_to 'Edit', edit_post_path(post)
  end

  def delete_post_button(post)
    return unless current_user && current_user == post.user

    link_to 'Delete', post_path(post), method: :delete
  end

  def show_dropdown_post_button(post)
    return unless edit_post_button(post) && delete_post_button(post)

    render 'posts/dropdown'
  end

  def autolink(text)
    text.gsub(/#\w+/) do |hashtag|
      link_to hashtag, hashtag_path(hashtag[1..-1])
    end.html_safe
  end
end

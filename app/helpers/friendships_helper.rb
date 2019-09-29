# frozen_string_literal: true

# TODO: refactor friendship and request controller to authorize user (first_friend_button) method
module FriendshipsHelper
  def show_friends
    if @friends.empty?
      render 'first_friend_request'
    else
      render @friends
    end
  end

  def first_friend_button(user)
    return if current_user == user

    if current_user.nil?
      link_to "Be #{@user.fullname}'s first friend", new_user_session_path
    elsif current_user.already_sent_request?(user)
      link_to 'Cancel Request', remove_request_user_path(user.id), method: :delete
    else
      link_to "Be #{@user.fullname}'s first friend", send_request_user_path(user.id), method: :post
    end
  end
end

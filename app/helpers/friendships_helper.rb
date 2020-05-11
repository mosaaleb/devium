# frozen_string_literal: true

module FriendshipsHelper
  def show_friends(friends)
    if friends.empty?
      render 'first_friend_request'
    else
      render friends
    end
  end

  def first_friend_button(user)
    return if current_user == user

    if current_user.already_sent_request?(user)
      button_to 'Cancel Request',
                remove_request_user_path(user.id),
                method: :delete,
                class: 'ml-auto btn btn-danger mt-2'
    else
      button_to "Be #{user.fullname}'s first friend",
                send_request_user_path(user.id),
                method: :post,
                class: 'ml-auto btn btn-primary mt-2'
    end
  end
end

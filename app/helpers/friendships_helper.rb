module FriendshipsHelper
  def show_friends(user)
    if @friends.empty?
      render 'first_friend_request'
    else
      render @friends
    end
  end

  def first_friend_button(user)
    case
      when current_user.nil?
        link_to "Be #{@user.username}'s first friend", new_user_session_path
      when current_user == user
        return
      when current_user.already_sent_request?(user)
        link_to 'Cancel Request', remove_request_user_path(user.id), method: :delete
      else
        link_to "Be #{@user.username}'s first friend",  send_request_user_path(user.id), method: :post
    end
  end
end

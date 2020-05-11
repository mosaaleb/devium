# frozen_string_literal: true

module ProfilesHelper
  def friendship_button(user)
    return if current_user == user

    if current_user.already_friends?(user)
      button_to 'Remove Friend',
                remove_friend_user_path(user.id),
                method: :delete, class: 'btn btn-danger btn-sm'
    elsif current_user.already_sent_request?(user)
      button_to 'Cancel Request',
                remove_request_user_path(user.id),
                method: :delete, class: 'btn btn-danger btn-sm'
    else
      button_to 'Send Request',
                send_request_user_path(user.id),
                method: :post, class: 'btn btn-primary btn-sm'
    end
  end

  def edit_profile_button(user)
    return unless current_user == user

    link_to 'Edit Profile', edit_user_profile_path(user.username)
  end

  def gender_details(user)
    return unless user.profile.gender

    user.profile.gender.capitalize
  end

  def gender_icon(user)
    return unless user.profile.gender

    if user.profile.gender == 'male'
      fa_icon 'male', class: 'fa-lg text-primary'
    elsif user.profile.gender == 'female'
      fa_icon 'female', class: 'fa-lg text-success'
    end
  end

  def show_birth_date(user)
    return unless user.profile.date_of_birth

    user.profile.date_of_birth.strftime('%B %d, %Y')
  end

  def birth_icon(user)
    return unless user.profile.date_of_birth

    fa_icon 'gift', class: 'fa-lg text-primary'
  end
end

# frozen_string_literal: true

module NotificationsHelper
  def notification_original_author_name(author)
    return 'your' if author == current_user

    "#{author.fullname}'s"
  end
end

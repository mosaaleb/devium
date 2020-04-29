# frozen_string_literal: true

module NotificationsHelper
  def objective(author)
    return 'your' if author == current_user

    "#{author.fullname}'s"
  end
end

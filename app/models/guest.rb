# frozen_string_literal: true

class Guest
  def id
    User.none
  end

  def liked?(_)
    false
  end

  def already_sent_request?(_)
    false
  end

  def already_friends?(_)
    false
  end
end

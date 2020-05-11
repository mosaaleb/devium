# frozen_string_literal: true

class Guest < User
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

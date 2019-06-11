class Request < ApplicationRecord
  # callbacks
  

  # Validations
  validates :sender_id, uniqueness: { scope: :receiver_id }
  validate :sender_and_receiver_are_not_friends

  # Associations
  belongs_to :receiver, class_name: 'User'
  belongs_to :sender, class_name: 'User'

  # Instance Methods
  def sender_and_receiver_are_not_friends
    if sender.friends.include?(receiver)
      errors.add(:sender_id, 'already friends')
    end
  end

end

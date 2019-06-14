class Request < ApplicationRecord
  # callbacks
  before_create :swap_sender_and_receiver_if_not_in_db

  # Validations
  validates :sender_id, uniqueness: { scope: :receiver_id }
  validate :sender_and_receiver_are_not_the_same_person
  validate :sender_and_receiver_are_not_friends
  validate :sender_and_receiver_does_not_already_have_requests

  # Associations
  belongs_to :receiver, class_name: 'User'
  belongs_to :sender, class_name: 'User'

  # Private Methods
  private 

  def sender_and_receiver_are_not_friends
    if sender.all_friends.include?(receiver) 
      errors.add(:sender_id, 'already friends')
    end
  end

  def sender_and_receiver_does_not_already_have_requests
    combinations = ["sender_id = #{sender_id} AND receiver_id = #{receiver_id}",
                    "sender_id = #{receiver_id} AND receiver_id = #{sender_id}"]

    if Request.where(combinations.join(' OR ')).exists?
      errors.add(:sender_id, 'request already sent')
    end
  end 

  def sender_and_receiver_are_not_the_same_person
    if sender == receiver
      errors.add(:sender_id, 'can\'t send a request to yourself')
    end
  end

  def swap_sender_and_receiver_if_not_in_db
    self.sender, self.receiver = self.receiver, self.sender unless record_found?
  end

  def record_found?
    Request.where(["sender_id = ? and receiver_id = ?", sender.id, receiver.id]).exists?
  end

end

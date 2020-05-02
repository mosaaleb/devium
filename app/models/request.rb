# frozen_string_literal: true

class Request < ApplicationRecord
  # callbacks

  # Validations
  validates :sender_id, uniqueness: { scope: :receiver_id }
  validate :sender_and_receiver_are_not_the_same_person
  validate :sender_and_receiver_are_not_friends
  validate :sender_and_receiver_does_not_already_have_requests

  # Associations
  belongs_to :receiver,
             class_name: 'User', counter_cache: :received_requests_count
  belongs_to :sender, class_name: 'User', counter_cache: :sent_requests_count

  # Private Methods
  private

  def sender_and_receiver_are_not_friends
    return unless sender.all_friends.include?(receiver)

    errors.add(:sender_id, 'already friends')
  end

  def sender_and_receiver_does_not_already_have_requests
    combinations = ["sender_id = #{sender_id} AND receiver_id = #{receiver_id}",
                    "sender_id = #{receiver_id} AND receiver_id = #{sender_id}"]

    return unless Request.where(combinations.join(' OR ')).exists?

    errors.add(:sender_id, 'request already sent')
  end

  def sender_and_receiver_are_not_the_same_person
    return unless sender == receiver

    errors.add(:sender_id, 'can\'t send a request to yourself')
  end
end

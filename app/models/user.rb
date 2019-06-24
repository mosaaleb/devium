class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :validatable

  # Validations
  validates :username, presence: true, uniqueness: true

  # Associations
  has_one :profile, dependent: :destroy
  accepts_nested_attributes_for :profile

  has_many :outgoing_requests, foreign_key: "sender_id", 
            dependent: :destroy, class_name: 'Request'
  has_many :outgoing_pending_friends, through: :outgoing_requests, source: :receiver

  has_many :incoming_requests, foreign_key: "receiver_id", 
            dependent: :destroy, class_name: 'Request'
  has_many :incoming_pending_friends, through: :incoming_requests, source: :sender

  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships

  has_many :inverse_friendships, class_name: 'Friendship', foreign_key: 'friend_id'
  has_many :inverse_friends, through: :inverse_friendships, source: :user

  has_many :posts, dependent: :destroy

  has_many :comments, dependent: :destroy

  has_many :likes, dependent: :destroy
  has_many :liked_comments, through: :likes, source: :likable, source_type: 'Comment'
  has_many :liked_posts, through: :likes, source: :likable, source_type: 'Post'

  # Instance methods
  def liked(likable)
    likable.kind_of?(Comment) ? liked_comments << likable : liked_posts << likable
  end
  
  def disliked(likable)
    likable.kind_of?(Comment) ? liked_comments.destroy(likable) : liked_posts.destroy(likable)
  end

  def adds_comment(comment)
    comments << comment
  end

  def sends_request(receiver)
    outgoing_requests.create receiver: receiver
  end

  def unsend_request(request)
    outgoing_requests.destroy request
  end

  def all_friends
    friends + inverse_friends
  end

  def to_param
    username
  end
end
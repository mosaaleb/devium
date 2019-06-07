class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :validatable

  # Callbacks
  after_create :create_profile

  # Validations
  validates :username, presence: true

  # Associations
  has_one :profile
  has_many :requests, foreign_key: "receiver_id", dependent: :destroy
  has_many :pending_friends, through: :requests, source: :sender

  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships, source: :friend
  # Instance methods

end

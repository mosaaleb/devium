class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :validatable

  # Callbacks
  after_create :create_profile

  # Validations
  validates :username, presence: true

  has_one :profile

  # Instance methods

end

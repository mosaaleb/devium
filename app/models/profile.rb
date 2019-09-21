# frozen_string_literal: true

class Profile < ApplicationRecord
  # Associations
  belongs_to :user

  # Enums
  enum gender: %i[female male]

  # Validations
  #validate :age_is_present_and_permitted
  #validates :date_of_birth, :gender, presence: true
  validates :first_name, :last_name, presence: true
  validates :about_me, length: { maximum: 400 }

  # Instance Methods
  def fullname
    "#{first_name} #{last_name}".proper_titlecase
  end

  # def age_is_present_and_permitted
  #   if date_of_birth.present? && Date.today.year - date_of_birth.year < 13
  #     errors.add(:date_of_birth, 'You are ineligible to register for Devium')
  #   end
  # end
end

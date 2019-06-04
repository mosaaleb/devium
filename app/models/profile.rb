class Profile < ApplicationRecord
  # Validations
  validate :age_is_present_and_permitted
  validates :date_of_birth, presence: true

  # Instance methods
  def age_is_present_and_permitted
    if date_of_birth.present? && Date.today.year - date_of_birth.year < 13
      errors.add(:date_of_birth, 'You are ineligible to register for devmedium')
    end
  end

  enum gender: [:female, :male]
end

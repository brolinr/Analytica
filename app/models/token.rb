# frozen_string_literal: true

class Token < ApplicationRecord
  before_create :generate_token_secret, :set_expiration

  enum purpose: { onboarding_approval: 0, onboarding_edit: 1 }
  enum status: { active: 0, void: 1 }

  belongs_to :generator, polymorphic: true

  validates :purpose, presence: true
  validates :status, presence: true
  validate :validate_token

  private

  def generate_token_secret
    loop do
      self.secret = SecureRandom.urlsafe_base64(64)
      break unless Token.exists?(secret: secret)
    end
  end

  def set_expiration
    self.expired_at = 1.hour.from_now if expired_at.blank?
  end

  def validate_token
    errors.add(:token, 'already exists') if Token.exists?(generator: generator, purpose: purpose, status: 0)
  end
end

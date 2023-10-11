# frozen_string_literal: true

class WatchedLot < ApplicationRecord
  belongs_to :lot
  belongs_to :company

  validate :validate_auction_expiration
  # rubocop:disable Rails/UniqueValidationWithoutIndex
  validates :lot_id, uniqueness: {
    scope: :company_id,
    message: I18n.t('activerecord.errors.models.watched_lot.errors.lot_watched')
  }
  # rubocop:enable Rails/UniqueValidationWithoutIndex

  private

  def validate_auction_expiration
    return if lot.blank?

    errors.add(:base, I18n.t('activerecord.errors.models.watched_lot.errors.deadline_passed')) if lot.auction.expired
  end
end

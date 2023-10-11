# frozen_string_literal: true

class WatchedLot < ApplicationRecord
  belongs_to :lot
  belongs_to :company

  validate :validate_auction_expiration
  validates :lot_id, uniqueness: { scope: :company_id, message: 'You have already added this lot to your collection' }

  private

  def validate_auction_expiration
    if lot.present? && lot.auction.expired
      errors.add(:base, 'The deadline for the auction has already passed. You cannot watch the lot')
    end
  end
end

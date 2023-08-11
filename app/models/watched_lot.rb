class WatchedLot < ApplicationRecord
  belongs_to :lot
  belongs_to :company

  validate :validate_auction_expiration

  private

  def validate_auction_expiration
    if Time.current >= lot.auction.deadline.to_time
      errors.add(:base, 'The deadline for the auction has already passed. You cannot watch the lot')
    end
  end
end

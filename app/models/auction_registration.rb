class AuctionRegistration < ApplicationRecord
  belongs_to :company
  belongs_to :auction

  validate :validate_auction_expiration
  validate :validate_company

  def approve_user
    transaction do
      update!(company_approved: true)
    end
  rescue ActiveRecord::RecordInvalid
    self
  end

  private

  def validate_auction_expiration
    if Time.current >= auction.deadline.to_time
      errors.add(:base, 'The deadline for the auction has already passed. You cannot be registered')
    end
  end

  def validate_company
    if company.present? && !company.seller?
      errors.add(:base, 'Only suppliers/sellers can subscribe to auctions. Upgrade your subscription')
    end

    if company.location != auction.location
      errors.add(:base, "You can't register to an auction that is not in your region.")
    end
  end
end

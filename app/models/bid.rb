class Bid < ApplicationRecord
  has_one_attached :image
  belongs_to :lot
  belongs_to :company

  validates :amount, presence: {message: 'Please enter the amount for the bid'}
  validate :validate_company
  validate :validate_bidding_price

  private

  def validate_bidding_price
    lot.with_lock do
      lot.reload
      unless lot.bids.empty? && amount <= lot.asking_price
        errors.add(:base, "Your bid must be equal to or lower than the asking price.")
      end

      if lot.bids.any?
        unless amount <= lot.bids.last.amount
          errors.add(:base, "Your bid must be lower than the previous bids.")
        end
      end
    end
  end

  def validate_company
    registration = AuctionRegistration.find_by(company_id: company_id, auction_id: lot.auction_id)
    unless registration
      errors.add(:base, "You cannot bid in this auction. Your company is not registered for participation.")
    end

    if company.location != lot.auction.location
      errors.add(:base, "You can't participate in an auction that is not in your region.")
    end

    if company.present? && !company.seller?
      errors.add(:base, 'Only sellers can bid for this lot. Upgrade your subscription')
    end
  end
end

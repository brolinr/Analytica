# frozen_string_literal: true

class Bid < ApplicationRecord
  has_many_attached :images
  belongs_to :lot
  belongs_to :company

  validates :amount, presence: { message: 'Please enter the amount for the bid' }
  validate :validate_company
  validate :validate_bidding_price
  validate :validate_image_count
  validate :validate_image_size

  private

  def validate_bidding_price
    if lot.present?
      lot.with_lock do
        lot.reload
        if lot.bids.empty? && amount > lot.asking_price
          errors.add(:base,
                     "Your bid must be equal to or lower than the asking price. The asking price is $#{lot.asking_price}")
        end

        if lot.bids.any? && (amount >= lot.bids.last.amount)
          errors.add(:base,
                     "Your bid must be lower than the previous bids. The current bid is $#{lot.bids.last.amount}")
        end
      end
    end
  end

  def validate_company
    registration = AuctionRegistration.find_by(company_id: company_id, auction_id: lot.auction.id) if lot.present?
    unless registration
      errors.add(:base, 'You cannot bid in this auction. Your company is not registered for participation.')
    end

    if company.present? && company.location != lot.auction.location
      errors.add(:base, "You can't participate in an auction that is not in your region.")
    end

    if company.present? && !company.seller?
      errors.add(:base, 'Only sellers can bid for this lot. Upgrade your subscription')
    end
  end

  def validate_image_count
    errors.add(:base, 'You can only add up to four images') if images.length > 4
  end

  def validate_image_size
    images.each do |image|
      if image.blob.byte_size > 5.megabytes
        image.purge
        errors.add(:images, "can't be larger than 5MB")
      end
    end
  end
end

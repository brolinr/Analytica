class Lot < ApplicationRecord
  belongs_to :company
  belongs_to :auction
  has_rich_text :description

  has_many :bids, dependent: :destroy
  has_many :watched_lots

  validates :title, presence: true
  validates :description, presence: true
  validate :auction_has_expired
  validate :validate_location
  validate :validate_company

  private

  def auction_has_expired
    if Time.current >= auction.deadline.to_time
      errors.add(:base, 'You cannot add a lot to this auction. The deadline for the auction has already passed.')
    end
  end

  def validate_location
    if auction.location != location
      errors.add(:base, 'You the location of the lot cannot be different to the location of the auction')
    end
  end

  def validate_company
    if company.present? && !company.buyer?
      errors.add(:base, 'Only buyers can create lots. Upgrade your subscription')
    end
  end
end

class Lot < ApplicationRecord
  before_create :assign_lot_number
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

  def collected?(current_company_id)
    watched_lots.exists?(lot_id: id, company_id: current_company_id)
  end

  def collect(current_company_id)
    watched_lots.create!(lot_id: id, company_id: current_company_id)
  end

  def remove_collection(current_company_id)
    watched_lot = watched_lots.find_by!(lot_id: id, company_id: current_company_id)
    watched_lot&.destroy if watched_lot
  end

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

  def assign_lot_number
    max_lot_number = auction.lots.maximum(:lot_number) || 0
    self.lot_number = max_lot_number + 1
  end
end

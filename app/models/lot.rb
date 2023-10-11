# frozen_string_literal: true

class Lot < ApplicationRecord
  before_create :assign_lot_number, :set_location
  belongs_to :company
  belongs_to :auction
  has_rich_text :description

  has_many :bids, dependent: :destroy
  has_many :watched_lots, dependent: :nullify

  validates :title, presence: true
  validates :description, presence: true
  validate :auction_has_expired
  validate :validate_company

  def collected?(current_company_id)
    watched_lot = WatchedLot.find_by(lot_id: id, company_id: current_company_id)

    watched_lot.present?
  end

  def collect(current_company_id)
    watched_lots.create!(lot_id: id, company_id: current_company_id)
  end

  def remove_collection(current_company_id)
    watched_lot = watched_lots.find_by!(lot_id: id, company_id: current_company_id)
    watched_lot&.destroy
  end

  def current_bid
    bids.last
  end

  def has_lost_lot(current_company)
    bids.any? && bids.last.company != current_company && bids.pluck(:company_id).include?(current_company.id)
  end

  private

  def auction_has_expired
    if auction.present? && Time.current >= auction.deadline.to_time
      errors.add(:base, 'You cannot add a lot to this auction. The deadline for the auction has already passed.')
    end
  end

  def validate_location
    if auction.present? && auction.location != location
      errors.add(:base, 'You the location of the lot cannot be different to the location of the auction')
    end
  end

  def validate_company
    errors.add(:base, 'Only buyers can create lots. Upgrade your subscription') if company.present? && !company.buyer?
  end

  def assign_lot_number
    max_lot_number = auction.lots.maximum(:lot_number) || 0
    self.lot_number = max_lot_number + 1
  end

  def set_location
    self.location = auction.location
  end
end

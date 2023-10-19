# frozen_string_literal: true

class Lot < ApplicationRecord
  before_create :assign_lot_number, :set_location

  has_rich_text :description

  belongs_to :company
  belongs_to :auction

  has_many :bids, dependent: :destroy
  has_many :watched_lots, dependent: :nullify

  validates :title, presence: true
  validates :description, presence: true

  validate :auction_expiry
  validate :locations
  validate :company_is_buyer?

  def collect(company_id)
    watched_lots.create!(lot_id: id, company_id: company_id)
  end

  def lost_lot?(company)
    bids.any? && bids.last.company != company && bids.pluck(:company_id).include?(company.id)
  end

  def collected?(company_id)
    watched_lot = WatchedLot.find_by(lot_id: id, company_id: company_id)
    watched_lot.present?
  end

  def current_bid
    bids.last
  end

  private

  def auction_expiry
    return if auction.blank?

    if Time.current >= auction.deadline.to_time
      errors.add(:base, I18n.t('activerecord.errors.models.lot.errors.deadline_passed'))
    end
  end

  def locations
    return if auction.blank?

    if auction.location != location
      errors.add(:base,
                 I18n.t('activerecord.errors.models.lot.errors.different_location'))
    end
  end

  def company_is_buyer?
    return if company.blank?

    errors.add(:base, I18n.t('activerecord.errors.models.lot.errors.only_buyers')) unless company.buyer?
  end

  def assign_lot_number
    max_lot_number = auction.lots.maximum(:lot_number) || 0
    self.lot_number = max_lot_number + 1
  end

  def set_location
    self.location = auction.location
  end
end

# frozen_string_literal: true

class Auction < ApplicationRecord
  before_create :set_location

  has_one_attached :image
  has_rich_text :description

  belongs_to :company
  has_many :auction_registrations, dependent: :destroy
  has_many :lots, dependent: :destroy

  validates :title, presence: true
  validates :description, presence: true
  validates :location, presence: true
  validates :start, presence: true
  validates :deadline, presence: true

  validate :validate_dates
  validate :validate_company

  def registered?(current_company)
    registration = AuctionRegistration.find_by(auction_id: id, company_id: current_company)

    if registration
      true
    else
      false
    end
  end

  private

  def validate_dates
    return if start.blank? || deadline.blank?

    errors.add(:base, I18n.t('activerecord.errors.models.auction.errors.deadline_later')) if start >= deadline
  end

  def validate_company
    return if company.blank?

    errors.add(:base, I18n.t('activerecord.errors.models.auction.errors.upgrade_subscription')) unless company.buyer?
  end

  def set_location
    return if company.blank?

    self.location = company.location
  end
end

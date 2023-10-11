# frozen_string_literal: true

class Bid < ApplicationRecord
  before_validation
  has_many_attached :images

  belongs_to :lot
  belongs_to :company

  validates :amount, presence: { message: I18n.t('activerecord.errors.models.bid.errors.amount_present') }

  validate :amount_bid
  validate :registration
  validate :locations
  validate :subscription
  validate :number_of_images
  validate :size_of_image

  private

  def amount_bid
    if lot.present?
      lot.with_lock do
        lot.reload

        if lot.bids.empty? && amount > lot.asking_price
          errors.add(:base, I18n.t('activerecord.errors.models.bid.errors.initial_bid_amount'))
        end

        if lot.bids.any? && (amount >= lot.bids.last.amount)
          errors.add(:base, I18n.t('activerecord.errors.models.bid.errors.second_to_more_bids'))
        end
      end
    end
  end

  def registration
    return if company_id.blank? || lot.blank?

    auction_reg = AuctionRegistration.find_by(company_id: company_id, auction_id: lot.auction.id)
    errors.add(:base, I18n.t('activerecord.errors.models.bid.errors.not_registered')) if auction_reg.blank?
  end

  def locations
    return if company.blank? || lot.blank?

    if company.location != lot.auction.location
      errors.add(:base, I18n.t('activerecord.errors.models.bid.errors.outside_region'))
    end
  end

  def subscription
    return if company.blank?

    errors.add(:base, I18n.t('activerecord.errors.models.bid.errors.only_seller')) unless company.seller?
  end

  def number_of_images
    errors.add(:base, I18n.t('activerecord.errors.models.bid.errors.image_limit')) if images.length > 4
  end

  def size_of_image
    return if images.blank?

    images.each do |image|
      if image.blob.byte_size > 5.megabytes
        image.purge
        errors.add(:images, I18n.t('activerecord.errors.models.bid.errors.image_size'))
      end
    end
  end
end

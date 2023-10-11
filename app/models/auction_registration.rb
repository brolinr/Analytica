# frozen_string_literal: true

class AuctionRegistration < ApplicationRecord
  belongs_to :company
  belongs_to :auction
  # rubocop:disable Rails/UniqueValidationWithoutIndex
  validates :auction_id, uniqueness: {
    scope: :company_id,
    message: I18n.t('activerecord.errors.models.auction_registration.errors.already_registered')
  }
  # rubocop:enable Rails/UniqueValidationWithoutIndex
  validate :auction_expiration
  validate :company_subscription
  validate :registration

  def approve_user
    transaction do
      update!(company_approved: true)
    end
  rescue ActiveRecord::RecordInvalid
    self
  end

  private

  def auction_expiration
    return if auction.blank?

    if Time.current >= auction.deadline.to_time
      errors.add(:base, I18n.t('activerecord.errors.models.auction_registration.errors.deadline_passed'))
    end
  end

  def company_subscription
    return if company.blank?

    unless company.seller?
      errors.add(:base,
                 I18n.t('activerecord.errors.models.auction_registration.errors.only_sellers'))
    end
  end

  def registration
    return if auction.blank? || company.blank?

    if company.location != auction.location
      errors.add(:base,
                 I18n.t('activerecord.errors.models.auction_registration.errors.outside_region'))
    end
  end
end

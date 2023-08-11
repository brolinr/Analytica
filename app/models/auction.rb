class Auction < ApplicationRecord
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
  validate :deadline_is_later_than_start
  validate :validate_company

  private

  def deadline_is_later_than_start
    if start.present? && deadline.present? && start >= deadline
      errors.add(:base, 'The deadline should be a date later than the start date')
    end
  end

  def validate_company
    if company.present? && !company.buyer?
      errors.add(:base, 'Only buyers can create auctions. Upgrade your subscription')
    end

    if company.location != location
      errors.add(:base, "You can't create an auction outside your region.")
    end
  end
end

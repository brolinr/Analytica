class Auction < ApplicationRecord
  before_create :validate_start_date

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
      return 'REGISTERED'
    else
      return 'NOT REGISTERED'
    end
  end

  private
  def validate_dates
    if start.present? && deadline.present? && start >= deadline
      errors.add(:base, 'The deadline should be a date later than the start date')
    end
  end

  def validate_start_date
    if start.present? && start <= Time.current
      errors.add(:base, 'The auction cannot start as a past date.')
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

# frozen_string_literal: true

class Company < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  has_one_attached :certificate_of_incorporation
  has_one_attached :tax_clearance
  has_one_attached :cr5
  has_one_attached :cr6
  has_one_attached :logo

  has_many :auctions, dependent: :destroy
  has_many :auction_registrations, dependent: :destroy
  has_many :bids, dependent: :destroy
  has_many :lots, dependent: :destroy
  has_many :watched_lots, dependent: :destroy

  validates :name, presence: true, length: { maximum: 50 }
  validates :about, length: { maximum: 300 }
  validates :phone, presence: true, length: { minimum: 10, maximum: 16 },
                    uniqueness: true
  validates :location, presence: true, length: { maximum: 50 }
  validates :address, presence: true, length: { maximum: 50 }
  # rubocop:disable Rails/I18nLocaleTexts
  validates :terms_and_conditions, presence: { message: 'Please accept the terms and conditions to continue' }
  validates :certificate_of_incorporation, presence:
                                           { message: 'Submit your certificate of incorporation to continue' },
                                           content_type: { in: 'application/pdf', message: 'must be in PDF format' },
                                           size: { less_than: 5.megabytes, message: 'should be less than 5MB' }
  validates :tax_clearance, presence:
                            { message: 'Submit your tax clearence certificate to continue' },
                            content_type: { in: 'application/pdf', message: 'must be in PDF format' },
                            size: { less_than: 5.megabytes, message: 'should be less than 5MB' }
  validates :cr5, presence:
            { message: 'Submit your CR5 certificate to continue' },
                  content_type: { in: 'application/pdf', message: 'must be in PDF format' },
                  size: { less_than: 5.megabytes, message: 'should be less than 5MB' }
  validates :cr6, presence:
            { message: 'Submit your CR6 certificate to continue' },
                  content_type: { in: 'application/pdf', message: 'must be in PDF format' },
                  size: { less_than: 5.megabytes, message: 'should be less than 5MB' }
  validates :logo, presence: false,
                   content_type: { in: %w[image/jpeg image/png], message: 'must be a valid image format' },
                   size: { less_than: 5.megabytes, message: 'should be less than 5MB' }

  # rubocop:enable Rails/I18nLocaleTexts
end

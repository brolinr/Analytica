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
  has_many :collected_lots, through: :watched_lots, source: :lot

  validates :name, presence: true, length: { maximum: 50 }
  validates :about, length: { maximum: 300 }
  validates :phone, presence: true, length: { minimum: 10, maximum: 16 },
                    uniqueness: true
  validates :location, presence: true, length: { maximum: 50 }
  validates :address, presence: true, length: { maximum: 50 }
  validates :terms_and_conditions, presence: {
    message: I18n.t('activerecord.errors.models.company.errors.terms_and_conditions.presence')
  }
  validates :certificate_of_incorporation,
            presence: {
              message: I18n.t('activerecord.errors.models.company.errors.certificate_of_incorporation.presence')
            },
            content_type: {
              in: 'application/pdf', message: I18n.t('activerecord.errors.models.company.errors.pdf_format')
            },
            size: {
              less_than: 5.megabytes, message: I18n.t('activerecord.errors.models.company.errors.less_than_5mb')
            }

  validates :tax_clearance,
            presence: { message: I18n.t('activerecord.errors.models.company.errors.tax_clearance.presence') },
            content_type: { in: 'application/pdf',
                            message: I18n.t('activerecord.errors.models.company.errors.pdf_format') },
            size: { less_than: 5.megabytes, message: I18n.t('activerecord.errors.models.company.errors.less_than_5mb') }

  validates :cr5,
            presence: { message: I18n.t('activerecord.errors.models.company.errors.cr5.presence') },
            content_type: { in: 'application/pdf',
                            message: I18n.t('activerecord.errors.models.company.errors.pdf_format') },
            size: { less_than: 5.megabytes, message: I18n.t('activerecord.errors.models.company.errors.less_than_5mb') }

  validates :cr6,
            presence: { message: I18n.t('activerecord.errors.models.company.errors.cr6.presence') },
            content_type: { in: 'application/pdf',
                            message: I18n.t('activerecord.errors.models.company.errors.pdf_format') },
            size: { less_than: 5.megabytes, message: I18n.t('activerecord.errors.models.company.errors.less_than_5mb') }

  validates :logo,
            presence: false,
            content_type: { in: %w[image/jpeg image/png],
                            message: I18n.t('activerecord.errors.models.company.errors.image_format') },
            size: { less_than: 5.megabytes, message: I18n.t('activerecord.errors.models.company.errors.less_than_5mb') }
end

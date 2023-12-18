module Company::Validations
  extend ActiveSupport::Concern
  included do
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
end
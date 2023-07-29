class Company < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  has_one_attached :certificate_of_incorporation
  has_one_attached :tax_clearance
  has_one_attached :cr5
  has_one_attached :cr6
  has_one_attached :logo

  validates :name, presence: true, length: { maximum: 50 }
  validates :about, length: { maximum: 300 }
  validates :phone, presence: true, length: { minimum: 10, maximum: 16 },
                    uniqueness: true
  validates :location, presence: true, length: { maximum: 50 }
  validates :address, presence: true, length: { maximum: 50 }
  validates :terms_and_conditions, presence: true
  validates :certificate_of_incorporation, presence: true,
                                           content_type: { in: 'application/pdf', message: 'must be in PDF format' },
                                           size: { less_than: 5.megabytes, message: 'should be less than 5MB' }
  validates :tax_clearance, presence: true,
                            content_type: { in: 'application/pdf', message: 'must be in PDF format' },
                            size: { less_than: 5.megabytes, message: 'should be less than 5MB' }
  validates :cr5, presence: true, content_type: { in: 'application/pdf', message: 'must be in PDF format' },
                  size: { less_than: 5.megabytes, message: 'should be less than 5MB' }
  validates :cr6, presence: true, content_type: { in: 'application/pdf', message: 'must be in PDF format' },
                  size: { less_than: 5.megabytes, message: 'should be less than 5MB' }
  validates :logo, presence: true,
                   content_type: { in: %w[image/jpeg image/png], message: 'must be a valid image format' },
                   size: { less_than: 5.megabytes, message: 'should be less than 5MB' }
end

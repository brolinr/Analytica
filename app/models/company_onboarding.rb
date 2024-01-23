# frozen_string_literal: true

class CompanyOnboarding < ApplicationRecord
  include Company::Attachments
  include Company::Validations

  enum approval: { pending_review: 0, approved: 1, disapproved: 2 }
  validates :reason_for_disapproval, length: { maximum: 300 }

  has_many :tokens, as: :generator, dependent: :destroy

  def self.ransackable_attributes(_auth_object = nil)
    %w[
      about address approval buyer created_at email id
      location name phone seller terms_and_conditions updated_at
    ]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[
      certificate_of_incorporation_attachment certificate_of_incorporation_blob
      cr5_attachment cr5_blob cr6_attachment cr6_blob logo_attachment logo_blob
      tax_clearance_attachment tax_clearance_blob
    ]
  end
end

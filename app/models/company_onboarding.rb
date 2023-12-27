# frozen_string_literal: true

class CompanyOnboarding < ApplicationRecord
  include Company::Attachments
  include Company::Validations

  enum approval: { pending_review: 0, approved: 1, disapproved: 2 }
end

# frozen_string_literal: true

module Company::Attachments
  extend ActiveSupport::Concern
  included do
    has_one_attached :certificate_of_incorporation
    has_one_attached :tax_clearance
    has_one_attached :cr5
    has_one_attached :cr6
    has_one_attached :logo
  end
end

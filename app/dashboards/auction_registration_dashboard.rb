# frozen_string_literal: true

require 'administrate/base_dashboard'

class AuctionRegistrationDashboard < Administrate::BaseDashboard
  ATTRIBUTE_TYPES = {
    id: Field::Number,
    auction: Field::BelongsTo,
    company: Field::BelongsTo,
    company_approved: Field::Boolean,
    created_at: Field::DateTime,
    updated_at: Field::DateTime
  }.freeze

  COLLECTION_ATTRIBUTES = %i[
    id
    auction
    company
    company_approved
  ].freeze

  SHOW_PAGE_ATTRIBUTES = %i[
    id
    auction
    company
    company_approved
    created_at
    updated_at
  ].freeze

  FORM_ATTRIBUTES = %i[
    auction
    company
    company_approved
  ].freeze

  COLLECTION_FILTERS = {
    approved: ->(resources) { resources.where(company_approved: true) },
    pending_approval: ->(resources) { resources.where(company_approved: nil) },
    disapproved: ->(resources) { resources.where(company_approved: false) }
  }.freeze

  def display_resource(auction_registration)
    "#{auction_registration.auction.title} Registration"
  end
end

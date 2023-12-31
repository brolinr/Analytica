# frozen_string_literal: true

require 'administrate/base_dashboard'

class BidDashboard < Administrate::BaseDashboard
  ATTRIBUTE_TYPES = {
    id: Field::String.with_options(searchable: false),
    amount: Field::Number,
    delivery_options: Field::Text,
    company: Field::BelongsTo,
    location: Field::String,
    lot: Field::BelongsTo,
    created_at: Field::DateTime,
    updated_at: Field::DateTime
  }.freeze

  COLLECTION_ATTRIBUTES = %i[
    id
    company
    lot
    amount
    location
    delivery_options
  ].freeze

  SHOW_PAGE_ATTRIBUTES = %i[
    id
    amount
    delivery_options
    company
    location
    lot
    created_at
    updated_at
  ].freeze

  FORM_ATTRIBUTES = %i[
    amount
    delivery_options
    company
    location
    lot
  ].freeze

  COLLECTION_FILTERS = {}.freeze

  def display_resource(bid)
    "#{bid.lot.title} Bid"
  end
end

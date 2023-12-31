# frozen_string_literal: true

require 'administrate/base_dashboard'

class AuctionDashboard < Administrate::BaseDashboard
  ATTRIBUTE_TYPES = {
    id: Field::String.with_options(searchable: false),
    title: Field::String,
    rich_text_description: Field::Text,
    location: Field::String,
    company: Field::BelongsTo,
    expired: Field::Boolean,
    deadline: Field::DateTime,
    start: Field::DateTime,
    notes: Field::Text,
    auction_registrations: Field::HasMany,
    lots: Field::HasMany,
    created_at: Field::DateTime,
    updated_at: Field::DateTime
  }.freeze

  COLLECTION_ATTRIBUTES = %i[
    id
    title
    location
    expired
    start
    deadline
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = %i[
    id
    title
    rich_text_description
    location
    company
    expired
    deadline
    start
    notes
    auction_registrations
    lots
    created_at
    updated_at
  ].freeze

  FORM_ATTRIBUTES = %i[
    title
    rich_text_description
    location
    company
    expired
    deadline
    start
    notes
    auction_registrations
    lots
  ].freeze

  COLLECTION_FILTERS = {
    expired: ->(resources) { resources.where(expired: true) },
    live: ->(resources) { resources.where(expired: true) }
  }.freeze

  def display_resource(auction)
    auction.title
  end
end

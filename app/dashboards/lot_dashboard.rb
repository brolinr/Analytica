# frozen_string_literal: true

require 'administrate/base_dashboard'

class LotDashboard < Administrate::BaseDashboard
  ATTRIBUTE_TYPES = {
    id: Field::Number,
    lot_number: Field::Number,
    title: Field::String,
    asking_price: Field::Number,
    condition: Field::String,
    location: Field::String,
    quantity: Field::Number,
    auction: Field::BelongsTo,
    company: Field::BelongsTo,
    bids: Field::HasMany,
    watched_lots: Field::HasMany,
    created_at: Field::DateTime,
    updated_at: Field::DateTime
  }.freeze

  COLLECTION_ATTRIBUTES = %i[
    id
    title
    condition
    location
    lot_number
    asking_price
    quantity
  ].freeze

  SHOW_PAGE_ATTRIBUTES = %i[
    id
    lot_number
    title
    asking_price
    condition
    location
    quantity
    auction
    company
    bids
    watched_lots
    created_at
    updated_at
  ].freeze

  FORM_ATTRIBUTES = %i[
    lot_number
    title
    asking_price
    condition
    location
    quantity
    auction
    company
    bids
    watched_lots
  ].freeze

  COLLECTION_FILTERS = {
    expired_auctions: lambda { |resources|
      resources.map do |resource|
        resource if resource.auction.expired?
      end
    }
  }.freeze

  def display_resource(lot)
    lot.title
  end
end

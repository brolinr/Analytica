# frozen_string_literal: true

require 'administrate/base_dashboard'

class WatchedLotDashboard < Administrate::BaseDashboard
  ATTRIBUTE_TYPES = {
    id: Field::Number,
    company: Field::BelongsTo,
    lot: Field::BelongsTo,
    created_at: Field::DateTime,
    updated_at: Field::DateTime
  }.freeze

  COLLECTION_ATTRIBUTES = %i[
    id
    company
    lot
    created_at
  ].freeze

  SHOW_PAGE_ATTRIBUTES = %i[
    id
    company
    lot
    created_at
    updated_at
  ].freeze

  FORM_ATTRIBUTES = %i[
    company
    lot
  ].freeze

  COLLECTION_FILTERS = {}.freeze

  def display_resource(watched_lot)
    "Saved lot #{watched_lot.lot.title}"
  end
end

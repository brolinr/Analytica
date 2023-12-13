# frozen_string_literal: true

require 'administrate/base_dashboard'

class CategoryDashboard < Administrate::BaseDashboard
  ATTRIBUTE_TYPES = {
    id: Field::Number,
    title: Field::String,
    created_at: Field::DateTime,
    updated_at: Field::DateTime
  }.freeze

  COLLECTION_ATTRIBUTES = %i[
    id
    title
    created_at
    updated_at
  ].freeze

  SHOW_PAGE_ATTRIBUTES = %i[
    id
    title
    created_at
    updated_at
  ].freeze

  FORM_ATTRIBUTES = %i[
    title
  ].freeze

  COLLECTION_FILTERS = {}.freeze

  def display_resource(category)
    category.title
  end
end

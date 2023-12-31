# frozen_string_literal: true

require 'administrate/base_dashboard'

class CompanyDashboard < Administrate::BaseDashboard
  ATTRIBUTE_TYPES = {
    id: Field::String.with_options(searchable: false),
    name: Field::String,
    email: Field::String,
    phone: Field::String,
    address: Field::String,
    unconfirmed_email: Field::String,
    terms_and_conditions: Field::Boolean,
    location: Field::String,
    buyer: Field::Boolean,
    seller: Field::Boolean,
    password: Field::Password,
    confirmation_token: Field::String,
    about: Field::Text,
    auction_registrations: Field::HasMany,
    auctions: Field::HasMany,
    bids: Field::HasMany,
    collected_lots: Field::HasMany,
    lots: Field::HasMany,
    lots_bid: Field::HasMany,
    watched_lots: Field::HasMany,
    reset_password_token: Field::String,
    remember_created_at: Field::DateTime,
    reset_password_sent_at: Field::DateTime,
    confirmation_sent_at: Field::DateTime,
    confirmed_at: Field::DateTime,
    created_at: Field::DateTime,
    updated_at: Field::DateTime
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = %i[
    id
    name
    email
    phone
    address
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = %i[
    id
    name
    email
    phone
    address
    unconfirmed_email
    terms_and_conditions
    location
    buyer
    seller
    password
    confirmation_token
    about
    auction_registrations
    auctions
    bids
    collected_lots
    lots
    lots_bid
    watched_lots
    reset_password_token
    remember_created_at
    reset_password_sent_at
    confirmation_sent_at
    confirmed_at
    created_at
    updated_at
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = %i[
    name
    email
    phone
    address
    terms_and_conditions
    location
    buyer
    seller
    password
    about
    auction_registrations
    auctions
    bids
    collected_lots
    lots
    lots_bid
    watched_lots
  ].freeze

  COLLECTION_FILTERS = {}.freeze

  def display_resource(company)
    company.name
  end
end

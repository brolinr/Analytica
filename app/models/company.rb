# frozen_string_literal: true

class Company < ApplicationRecord
  include Company::Attachments

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  has_many :auctions, dependent: :destroy
  has_many :auction_registrations, dependent: :destroy
  has_many :bids, dependent: :destroy
  has_many :lots, dependent: :destroy
  has_many :watched_lots, dependent: :destroy
  has_many :collected_lots, through: :watched_lots, source: :lot
  has_many :lots_bid, through: :bids, source: :lot

  include Company::Validations
end

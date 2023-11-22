# frozen_string_literal: true

module LotsHelper
  def collected?(company_id)
    watched_lot = WatchedLot.find_by(lot_id: id, company_id: company_id)
    watched_lot.present?
  end

  def current_bid
    bids.last
  end

  def lost_lot?(company, lot, bids=lot.bids)
    bids.any? && bids.last.company != company && bids.companies.include?(company)
  end

  def won_lot?(lot, company, bids=lot.bids)
    bids.last.company == company && lot.auction.expired?
  end
end

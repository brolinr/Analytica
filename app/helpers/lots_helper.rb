# frozen_string_literal: true

module LotsHelper
  def lost_lot?(company, lot, bids = lot.bids)
    return false if bids.empty?

    bids.any? && bids.last.company != company && bids.companies.include?(company)
  end

  def won_lot?(lot, company, bids = lot.bids)
    return false if bids.empty?
    bids.last.company == company && lot.auction.expired?
  end
end

# frozen_string_literal: true

module LotsHelper
  def lost_lot?(company)
    bids.any? && bids.last.company != company && bids.pluck(:company_id).include?(company.id)
  end

  def collected?(company_id)
    watched_lot = WatchedLot.find_by(lot_id: id, company_id: company_id)
    watched_lot.present?
  end

  def current_bid
    bids.last
  end
end

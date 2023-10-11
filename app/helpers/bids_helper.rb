# frozen_string_literal: true

module BidsHelper
  def max_bid(lot)
    if lot.bids.empty?
      lot.asking_price
    else
      lot.bids.last.amount
    end
  end

  def min_bid; end

  def validate_bidding_price
    lot.with_lock do
      lot.reload
      unless lot.bids.empty? && amount <= lot.asking_price
        errors.add(:base, 'Your bid must be equal to or lower than the asking price.')
      end

      if lot.bids.any? && amount > lot.bids.last.amount
        errors.add(:base, 'Your bid must be lower than the previous bids.')
      end
    end
  end
end

# frozen_string_literal: true

require 'rails_helper'

RSpec.describe WatchedLot do
  let(:company) { create(:company, :as_buyer) }
  let(:auction) { create(:auction, company: company, location: company.location) }
  let(:lot) { create(:lot, company: company, auction: auction, location: auction.location) }
  let(:watched_lot) { described_class.new(lot_id: lot.id, company_id: company.id) }

  describe 'relations' do
    it { is_expected.to belong_to(:lot) }
    it { is_expected.to belong_to(:company) }
  end
end

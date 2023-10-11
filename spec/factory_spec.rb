# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Factories' do
  let(:buyer) { create(:company, :as_buyer) }
  let(:auction) { create(:auction, company_id: buyer.id, location: buyer.location) }

  describe 'Company factory' do
    it 'creates a company' do
      expect { create(:company) }.to change(Company, :count).by(1)
    end
  end

  describe 'Auction factory' do
    it 'creates an auction without trait' do
      expect { create(:auction, company_id: buyer.id, location: buyer.location) }.to change(Auction, :count).by(1)
    end

    it 'creates an auction with buyer trait', :aggregate_failures do
      expect { create(:auction, :with_company) }.to change(Auction, :count).by(1)
      expect(Auction.last).not_to match(buyer)
    end
  end

  describe 'Lot factory' do
    it 'creates a lot' do
      expect do
        create(:lot, auction_id: auction.id, company_id: buyer.id, location: buyer.location)
      end.to change(Auction, :count).by(1)
    end
  end
end

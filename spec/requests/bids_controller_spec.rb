# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BidsController, type: :controller do
  let(:company) { create(:company, buyer: true, seller: true) }
  let!(:auction) { create(:auction, company: company, location: company.location) }
  let!(:lot) { create(:lot, auction: auction) }
  let(:bid) { Bid.create(amount: 100, lot: lot, company: company) }

  before do
    sign_in company
    AuctionRegistration.create(auction: auction, company: company)
  end

  describe 'create' do
    context 'with correct params' do
      let(:request) do
        post :create, params:
          {
            auction_id: auction.id,
            lot_id: lot.id,
            bid: {
              amount: 100
            }
          }
      end

      it 'creates bid' do
        expect { request }.to change(Bid, :count).by(1)
      end
    end

    context 'with incorrect params' do
      let(:request) do
        post :create, params:
          {
            auction: { invalid: nil }
          }
      end

      it 'does not create bid' do
        expect { request }.to raise_error(ActionController::UrlGenerationError)
      end
    end
  end

  describe 'destroy' do
    context 'with correct params' do
      let(:request) do
        post :destroy, params:
          {
            auction_id: auction.id,
            lot_id: lot.id,
            id: bid.id
          }
      end

      it 'destroys bid' do
        bid
        expect { request }.to change(Bid, :count).from(1).to(0)
      end
    end

    context 'with incorrect params' do
      let(:request) do
        delete :destroy, params:
          {
            id: nil
          }
      end

      it 'does not destroy bid' do
        expect { request }.to raise_error(ActionController::UrlGenerationError)
      end
    end
  end
end

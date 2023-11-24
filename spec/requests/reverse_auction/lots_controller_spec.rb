# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ReverseAuction::LotsController, type: :controller do
  let(:company) { create(:company, buyer: true) }
  let!(:auction) { create(:auction, company: company, location: company.location) }
  let(:lot) { create(:lot, auction: auction, location: auction.location) }

  before do
    sign_in company
  end

  describe 'create' do
    context 'with correct params' do
      let(:request) do
        post :create, params:
          {
            auction_id: auction.id,
            lot: {
              title: FFaker::Product.brand,
              quantity: rand(100),
              asking_price: rand * 1000,
              description: FFaker::Book.description,
              location: company.location
            }
          }
      end

      it 'creates lot' do
        expect { request }.to change(Lot, :count).by(1)
      end
    end

    context 'with incorrect params' do
      let(:request) do
        post :create, params:
          {
            auction_id: auction.id,
            lot: { invalid: nil }
          }
      end

      it 'does not create lot' do
        expect { request }.not_to change(Lot, :count)
      end
    end
  end

  describe 'destroy' do
    context 'with correct params' do
      let(:request) do
        post :destroy, params:
          {
            auction_id: auction.id,
            id: lot.id
          }
      end

      it 'destroys lot' do
        lot
        expect { request }.to change(Lot, :count).from(1).to(0)
      end
    end

    context 'with incorrect params' do
      let(:request) do
        delete :destroy, params:
          {
            id: nil
          }
      end

      it 'does not destroy lot' do
        expect { request }.to raise_error(ActionController::UrlGenerationError)
      end
    end
  end

  describe 'wish' do
    context 'with correct params' do
      let(:request) do
        post :wish, params:
          {
            auction_id: auction.id,
            id: lot.id
          }
      end

      it 'wishs lot' do
        lot
        expect { request }.to change(WatchedLot, :count).from(0).to(1)
      end
    end

    context 'with incorrect params' do
      let(:request) do
        post :wish, params:
          {
            id: nil
          }
      end

      it 'does not wish lot' do
        expect { request }.to raise_error(ActionController::UrlGenerationError)
      end
    end
  end
end

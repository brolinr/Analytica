# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ReverseAuction::AuctionsController, type: :controller do
  let(:company) { create(:company, :as_buyer) }
  let!(:auction) { create(:auction, company: company, location: company.location) }

  before { sign_in company }

  describe 'create' do
    context 'with correct params' do
      let(:request) do
        post :create, params:
          {
            auction: {
              title: 'New Auction',
              description: 'Desc',
              location: company.location,
              start: Time.current,
              deadline: 5.days.from_now
            }
          }
      end

      it 'creates auction' do
        expect { request }.to change(Auction, :count).by(1)
      end
    end

    context 'with incorrect params' do
      let(:request) do
        post :create, params:
          {
            auction: { invalid: nil }
          }
      end

      it 'does not create auction' do
        expect { request }.not_to change(Auction, :count)
      end
    end
  end

  describe 'update' do
    context 'with correct params' do
      let(:request) do
        patch :update, params:
          { id: auction.id,
            auction: { title: 'Updated Title' } }
      end

      it 'updates auction' do
        expect { request }.to change { Auction.last.title }.from(auction.title).to('Updated Title')
      end
    end

    context 'with incorrect params' do
      let(:request) do
        patch :update, params:
          {
            id: auction.id,
            auction: { invalid: nil }
          }
      end

      it 'does not update auction' do
        expect { request }.not_to change(Auction, :last)
      end
    end
  end

  describe 'destroy' do
    context 'with correct params' do
      let(:request) do
        post :destroy, params:
          { id: auction.id }
      end

      it 'destroys auction' do
        expect { request }.to change(Auction, :count).from(1).to(0)
      end
    end

    context 'with incorrect params' do
      let(:request) do
        delete :destroy, params:
          {
            id: nil
          }
      end

      it 'does not destroy auction' do
        expect { request }.to raise_error(ActionController::UrlGenerationError)
      end
    end
  end

  describe 'register' do
    before { company.update(seller: true) }

    context 'with correct params' do
      let(:request) do
        post :register, params:
          { id: auction.id }
      end

      it 'registers current user for auction' do
        expect { request }.to change(AuctionRegistration, :count).to(1).from(0)
      end
    end

    context 'with incorrect params' do
      let(:request) do
        post :register, params:
          {}
      end

      it 'does not register company' do
        expect { request }.to raise_error(ActionController::UrlGenerationError)
      end
    end
  end
end

# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ReverseAuction::AuctionsController, type: :controller do
  let(:company) { create(:company, :as_buyer) }
  let!(:auction) { create(:auction, company: company, location: company.location) }

  before { sign_in company }

  describe 'GET #new' do
    it 'returns http success' do
      get :new
      expect(response).to be_successful
    end
  end

  describe 'create' do
    context 'with correct params' do
      let(:request) { post :create, params: { auction: attributes_for(:auction) } }

      it 'creates auction' do
        expect { request }.to change(Auction, :count).by(1)
      end
    end

    context 'with incorrect params' do
      let(:request) { post :create, params: { auction: { invalid: nil } } }

      it 'does not create auction' do
        expect { request }.not_to change(Auction, :count)
      end
    end
  end

  describe 'update' do
    context 'with correct params' do
      let(:request) { patch :update, params: { id: auction.id, auction: { title: 'Updated Title' } } }

      it 'updates auction' do
        expect { request }.to change { Auction.last.title }.from(auction.title).to('Updated Title')
      end
    end

    context 'with incorrect params' do
      let(:request) { patch :update, params: { id: auction.id, auction: { invalid: nil } } }

      it 'does not update auction' do
        expect { request }.not_to change(Auction, :last)
      end
    end
  end

  describe 'destroy' do
    context 'with correct params' do
      let(:request) { post :destroy, params: { id: auction.id } }

      it 'destroys auction' do
        expect { request }.to change(Auction, :count).from(1).to(0)
      end
    end

    context 'with incorrect params' do
      let(:request) { delete :destroy, params: { id: nil } }

      it 'does not destroy auction' do
        expect { request }.to raise_error(ActionController::UrlGenerationError)
      end
    end
  end

  describe 'register' do
    before { company.update(seller: true) }

    context 'with correct params' do
      let(:request) { post :register, params: { id: auction.id } }

      it 'registers current user for auction' do
        expect { request }.to change(AuctionRegistration, :count).to(1).from(0)
      end
    end

    context 'with incorrect params' do
      let(:request) { post :register, params: {} }

      it 'does not register company' do
        expect { request }.to raise_error(ActionController::UrlGenerationError)
      end
    end
  end
end

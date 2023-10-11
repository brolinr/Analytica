# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Auction do
  let(:auction) { create(:auction, :with_company) }

  describe 'relations' do
    it { is_expected.to belong_to(:company) }
    it { is_expected.to have_many(:auction_registrations).dependent(:destroy) }
    it { is_expected.to have_many(:lots).dependent(:destroy) }
    it { is_expected.to have_one_attached(:image) }
    it { is_expected.to have_rich_text(:description) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:description) }
    it { is_expected.to validate_presence_of(:location) }
    it { is_expected.to validate_presence_of(:start) }
    it { is_expected.to validate_presence_of(:deadline) }

    context 'when validating dates' do
      it 'start should not be later than deadline' do
        auction.deadline = auction.start - 3.days
        expect(auction).not_to be_valid
      end
    end

    context 'when validating companies' do
      before { auction.company.buyer = true }

      it { expect(auction).to be_valid }

      it 'has same location as company' do
        auction.location = nil
        expect(auction).not_to be_valid
      end
    end
  end

  describe 'factories' do
    it { expect { auction }.to change(described_class, :count).by(1) }
    it { expect(auction.company).not_to be_nil }
    it { expect(auction.company.buyer).to be_truthy }
  end
end

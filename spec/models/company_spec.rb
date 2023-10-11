# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Company do
  describe 'relations' do
    it { is_expected.to have_many(:auctions).dependent(:destroy) }
    it { is_expected.to have_many(:auction_registrations).dependent(:destroy) }
    it { is_expected.to have_many(:bids).dependent(:destroy) }
    it { is_expected.to have_many(:lots).dependent(:destroy) }
    it { is_expected.to have_many(:watched_lots).dependent(:destroy) }
    it { is_expected.to have_one_attached(:certificate_of_incorporation) }
    it { is_expected.to have_one_attached(:tax_clearance) }
    it { is_expected.to have_one_attached(:cr5) }
    it { is_expected.to have_one_attached(:cr6) }
    it { is_expected.to have_one_attached(:logo) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_length_of(:name).is_at_most(50) }
    it { is_expected.to validate_length_of(:about).is_at_most(300) }
    it { is_expected.to validate_presence_of(:phone) }
    it { is_expected.to validate_length_of(:phone).is_at_least(10).is_at_most(16) }
    it { is_expected.to validate_uniqueness_of(:phone) }
    it { is_expected.to validate_presence_of(:location) }
    it { is_expected.to validate_length_of(:location).is_at_most(50) }
    it { is_expected.to validate_presence_of(:address) }
    it { is_expected.to validate_length_of(:address).is_at_most(50) }

    it do
      expect(subject).to validate_presence_of(:terms_and_conditions)
        .with_message('Please accept the terms and conditions to continue')
    end
  end

  describe 'factories' do
    let(:company) { create(:company) }

    it { expect { company }.to change(described_class, :count).by(1) }
  end
end

# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Lot do
  let(:lot) { create(:lot) }

  describe 'relations' do
    it { is_expected.to belong_to(:company) }
    it { is_expected.to belong_to(:auction) }
    it { is_expected.to have_many(:bids).dependent(:destroy) }
    it { is_expected.to have_many(:watched_lots).dependent(:destroy) }
    it { is_expected.to have_rich_text(:description) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:description) }
  end

  describe 'factories' do
    it { expect { lot }.to change(described_class, :count).by(1) }
  end
end

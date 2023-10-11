# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Bid do
  describe 'relations' do
    it { is_expected.to belong_to(:company) }
    it { is_expected.to belong_to(:lot) }
    it { is_expected.to have_many_attached(:images) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:amount).with_message('Please enter the amount for the bid') }
  end
end

# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CompanyOnboarding do
  describe 'validations' do
    i18n_path = 'activerecord.errors.models.company.errors.terms_and_conditions.presence'
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
    it { is_expected.to validate_presence_of(:terms_and_conditions).with_message(I18n.t(i18n_path)) }
  end

  describe 'factories' do
    let(:company_onboarding) { create(:company_onboarding) }

    it { expect { company_onboarding }.to change(described_class, :count).by(1) }
  end
end

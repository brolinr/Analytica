# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CompanyOnboardingsController, type: :controller do
  let(:company_onboarding) { create(:company_onboarding) }

  describe 'GET #new' do
    it 'returns http success' do
      get :new
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    context 'with correct params' do
      let(:request) { post :create, params: { company_onboarding: attributes_for(:company_onboarding) } }

      it 'creates company_onboarding', :aggregate_failures do
        flash_path = 'controllers.company_onboadings.create.success'
        expect { request }.to change(CompanyOnboarding, :count).from(0).to(1)
        expect(response).to redirect_to(root_path)
        expect(flash[:notice]).to eq(I18n.t(flash_path))
      end
    end

    context 'with incorrect params' do
      let(:request) { post :create, params: { company_onboarding: { invalid: nil } } }

      it 'does not create company_onboarding' do
        expect { request }.not_to change(CompanyOnboarding, :count)
      end
    end
  end
end

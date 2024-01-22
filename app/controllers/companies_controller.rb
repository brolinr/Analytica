# frozen_string_literal: true

class CompaniesController < ApplicationController
  def new
    redirect_to root_path unless company_onboarding.is_a?(CompanyOnboarding)
    redirect_to root_path if company.is_a?(Company)
  end

  def create # rubocop:disable Metrics/AbcSize
    @company = Company.new(
      name: company_onboarding.name,
      email: company_onboarding.email,
      phone: company_onboarding.phone,
      address: company_onboarding.address,
      location: company_onboarding.location,
      terms_and_conditions: company_onboarding.terms_and_conditions,
      cr5: company_onboarding.cr5.attachment.blob,
      cr6: company_onboarding.cr6.attachment.blob,
      certificate_of_incorporation: company_onboarding.certificate_of_incorporation.attachment.blob,
      tax_clearance: company_onboarding.tax_clearance.attachment.blob,
      password: params[:password],
      password_confirmation: params[:password_confirmation]
    )

    if @company.save
      session[:company_id] = @company.id
      redirect_to new_company_session_path, notice: I18n.t('controllers.company_onboardings.approved.success')
    else
      render :new
    end
  end

  private

  def company_onboarding
    @company_onboarding ||= CompanyOnboarding.find_by(
      approval_token: params[:approval_token] || params[:company][:approval_token]
    )
  end

  def company
    @company ||= Company.find_by(email: company_onboarding.email)
  end
end

# frozen_string_literal: true

class CompanyOnboardingMailer < ApplicationMailer
  include Rails.application.routes.url_helpers
  before_action :company_onboarding

  def approve
    mail(to: company_onboarding.email, subject: I18n.t('approve.subject', scope: i18n_scope))
    @finish_url = company_onboarding_url(company_onboarding)
  end

  def disapprove
    mail(to: company_onboarding.email, subject: I18n.t('disapprove.subject', scope: i18n_scope))
    @restart_process_path = new_company_onboarding_url(company_onboarding)
  end

  private

  def i18n_scope
    'mailers.company_onboarding'
  end

  def company_onboarding
    @company_onboarding ||= params[:company_onboarding].reload
  end
end

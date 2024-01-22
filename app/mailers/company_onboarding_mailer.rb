# frozen_string_literal: true

class CompanyOnboardingMailer < ApplicationMailer
  before_action :company_onboarding

  def approve
    @finish_url = Rails.application.routes.url_helpers.new_company_url(approval_token: company_onboarding.reload.approval_token)
    mail(to: company_onboarding.email, subject: I18n.t('approve.subject', scope: i18n_scope))
  end

  def disapprove
    @restart_process_path = Rails.application.routes.url_helpers.new_company_onboarding_url
    mail(to: company_onboarding.email, subject: I18n.t('disapprove.subject', scope: i18n_scope))
  end

  private

  def i18n_scope
    'mailers.company_onboarding'
  end

  def company_onboarding
    @company_onboarding ||= params[:company_onboarding].reload
  end
end

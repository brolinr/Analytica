# frozen_string_literal: true

class CompanyOnboardingsController < ApplicationController
  before_action :authenticate_administrator!, except: %i[new create]
  before_action :company_onboarding, except: %i[new create index]

  def new
    @company_onboarding = CompanyOnboarding.new
  end

  def create
    @company_onboarding = CompanyOnboarding.new(permitted_params)

    if @company_onboarding.save
      redirect_to root_path, flash: { notice: I18n.t('create.success', scope: i18n_scope) }
    else
      render :new
    end
  end

  def show; end

  def index
    @q = CompanyOnboarding.ransack(params[:q])
    @company_onboardings = @q.result(distinct: true)
  end

  def approve
    if company_onboarding.is_a?(CompanyOnboarding) && company_onboarding.pending_review?
      case approval_params[:approval]
      when 'approved'
        company_onboarding.approved!
        CompanyOnboardingMailer.with(company_onboarding: company_onboarding).approve.deliver_later
        redirect_to company_onboardings_path, flash: { notice: I18n.t('approved.success', scope: i18n_scope) }
      when 'disapproved'
        company_onboarding.disapproved!
        company_onboarding.update!(reason_for_disapproval: approval_params[:reason_for_disapproval])
        CompanyOnboardingMailer.with(
          company_onboarding: company_onboarding,
          reason_for_disapproval: approval_params[:reason_for_disapproval]
        ).disapprove.deliver_later
        redirect_to company_onboardings_path, flash: { notice: I18n.t('disapproved.success', scope: i18n_scope) }
      end
    else
      redirect_to company_onboardings_path, flash: { alert: I18n.t('approved.failure', scope: i18n_scope) }
    end
  end

  private

  def permitted_params
    params.require(:company_onboarding).permit(
      :email, :name, :phone, :address, :location,
      :certificate_of_incorporation, :tax_clearance,
      :cr5, :cr6, :terms_and_conditions, :password,
      :password_confirmation, :current_password
    )
  end

  def approval_params
    params.require(:company_onboarding).permit(:approval, :reason_for_disapproval)
  end

  def i18n_scope
    'controllers.company_onboadings'
  end

  def company_onboarding
    @company_onboarding ||= CompanyOnboarding.find(params[:id])
  end
end

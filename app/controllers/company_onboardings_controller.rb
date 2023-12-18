class CompanyOnboardingsController < ApplicationController
  def new
    @company_onboarding = CompanyOnboarding.new
  end
  
  def create
    @company_onboarding = CompanyOnboarding.new(permitted_params)
    
    if @company_onboarding.save
      redirect_to root_path, flash: { notice: 'Your details have been sent for verification. We will send you an email soon'}
    else
      return render :new
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
end

# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :devise_permitted_params, if: :devise_controller?

  private

  def devise_permitted_params
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(allowed_params) }
    devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(allowed_params) }
  end

  def allowed_params
    %i[email name phone address location
       certificate_of_incorporation tax_clearance
       cr5 cr6 terms_and_conditions password password_confirmation current_password]
  end
end

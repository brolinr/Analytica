# frozen_string_literal: true

class Companies::RegistrationsController < Devise::RegistrationsController
  layout :resolve_layout
  prepend_before_action :require_no_authentication, only: [:new, :create, :cancel]
  prepend_before_action :authenticate_scope!, only: [:edit, :update, :destroy]
  prepend_before_action :set_minimum_password_length, only: [:new, :edit]

  def new
    build_resource
    yield resource if block_given?
    respond_to do |format|
      format.html { respond_with resource }
    end
  end

  def create
    build_resource(sign_up_params)
    resource.save
    yield resource if block_given?

    if resource.persisted?
      handle_signed_up_resource
    else
      handle_failed_resource_creation
    end
  end

  def edit
    render :edit
  end

  def update
    self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)
    prev_unconfirmed_email = resource.unconfirmed_email if resource.respond_to?(:unconfirmed_email)

    resource_updated = update_resource(resource, account_update_params)
    yield resource if block_given?

    if resource_updated
      handle_successful_update(resource, prev_unconfirmed_email)
    else
      handle_failed_update(resource)
    end
  end

  def destroy
    # ... (unchanged)
  end

  # ... (unchanged)

  private

  # ... (unchanged)

  def handle_signed_up_resource
    if resource.active_for_authentication?
      set_flash_message! :notice, :signed_up
      sign_up(resource_name, resource)
      respond_with resource, location: after_sign_up_path_for(resource)
    else
      set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
      expire_data_after_sign_in!
      respond_with resource, location: after_inactive_sign_up_path_for(resource)
    end
  end

  def handle_failed_resource_creation
    clean_up_passwords resource
    set_minimum_password_length
    respond_with resource
  end

  def handle_successful_update(resource, prev_unconfirmed_email)
    set_flash_message_for_update(resource, prev_unconfirmed_email)
    bypass_sign_in resource, scope: resource_name if sign_in_after_change_password?

    respond_with resource, location: after_update_path_for(resource)
  end

  def handle_failed_update(resource)
    clean_up_passwords resource
    set_minimum_password_length
    respond_with resource
  end
end

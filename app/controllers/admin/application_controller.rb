# frozen_string_literal: true

class Admin::ApplicationController < Administrate::ApplicationController
  before_action :authenticate_administrator!
end

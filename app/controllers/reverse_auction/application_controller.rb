# frozen_string_literal: true

class ReverseAuction::ApplicationController < ApplicationController
  before_action :authenticate_company!
  before_action :current_company
  layout 'reverse_auction_application'
end

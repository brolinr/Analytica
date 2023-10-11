# frozen_string_literal: true

class BidsController < ApplicationController
  before_action :auction, :lot, only: :new
  def new
    @bid = Bid.new
  end

  def create
    @bid = current_company.bids.new(permitted_params)
    @bid.lot = lot
    @bid.location = auction.location

    if @bid.save
      flash[:success] = I18n.t('controllers.bids.create_success')
      redirect_to auction_lot_path(auction, lot)
    else
      render 'new', status: :unprocessable_entity
    end
  end

  def destroy
    flash[:notice] = I18n.t('controllers.bids.destroy_success') if bid.destroy
    redirect_to request.referer unless request.referer.nil?
  end

  private

  def bid
    @bid = Bid.find(params[:id])
  end

  def auction
    @auction = Auction.find(params[:auction_id])
  end

  def lot
    @lot = Lot.find(params[:lot_id])
  end

  def permitted_params
    params.require(:bid).permit(:amount, :delivery_options, images: [])
  end
end

# frozen_string_literal: true

class ReverseAuction::BidsController < ReverseAuction::ApplicationController
  before_action :permitted_params, only: :create

  def lots_bid
    @lots = current_company.lots_bid
    @bid = Bid.new
  end

  def new
    @bid = Bid.new
  end

  def create
    @bid = current_company.bids.build(permitted_params)
    @bid.lot = lot
    @bid.location = lot.auction.location

    if @bid.save
      redirect_to request.referer, flash: { notice: I18n.t('controllers.bids.create_success') }
    else
      render 'new'
    end
  end

  def destroy
    if bid.destroy && !request.referer.empty?
      redirect_to request.referer, flash: { notice: I18n.t('controllers.bids.destroy_success') }
    end
  end

  private

  def auction
    @auction = Auction.find(params[:auction_id])
  end

  def bid
    @bid = Bid.find(params[:id])
  end

  def lot
    @lot = Lot.find(params[:lot_id])
  end

  def permitted_params
    params.require(:bid).permit(:amount, :delivery_options, images: [])
  end
end

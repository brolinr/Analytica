class BidsController < ApplicationController
  before_action :auction, :lot, only: :new
  def new
    @bid = Bid.new
  end
  def create
    @bid = current_company.bids.new(bid_params)
    @bid.lot = lot
    @bid.location = auction.location
    if @bid.save
      flash[:success] = 'Bid submitted!'
      redirect_to auction_lot_path(auction, lot)
    else
      render 'new', status: :unprocessable_entity
    end

  end

  def destroy
    flash[:notice] = 'Bid retracted!' if bid.destroy
    redirect_to request.referer
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

  def bid_params
    permitted_params = params.require(:bid).permit(:amount, :delivery_options, images: [])
    permitted_params
  end
end

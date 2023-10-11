# frozen_string_literal: true

class LotsController < ApplicationController
  before_action :auction, except: :collections
  before_action :correct_company, except: :collections
  before_action :lot, except: %i[create collections]

  def show; end

  def create
    @lot = auction.lots.build(lot_params)
    @lot.company = auction.company
    @lot.location = @auction.location
    if @lot.save
      redirect_to edit_auction_path(auction.id),
                  flash: {
                    notice: 'Congratulations on adding
                             your lot.'
                  }
    else
      redirect_to edit_auction_path(auction),
                  flash: {
                    error: 'Congratulations on adding
                             your lot.'
                  }
    end
  end

  def destroy
    if lot.destroy
      redirect_to edit_auction_path(auction),
                  flash: { notice: 'The lot has been successfully deleted.' }
    else
      flash[:error] = auction.errors.full_messages
    end
  end

  def collect
    @collection = WatchedLot.find_by(company_id: current_company, lot_id: @lot.id)

    if @collection.present?
      @collection.destroy
      flash[:notice] = 'Lot removed from collection!'
    else
      @collection = WatchedLot.new(company_id: current_company.id, lot_id: @lot.id)
      flash[:notice] = 'Lot Collected' if @collection.save
    end
    redirect_to request.referer if request.referer.present?
  end

  def collections
    company_watched_lots = WatchedLot.where(company_id: current_company.id).pluck(:lot_id)
    @collections = Lot.where(id: company_watched_lots)
    @live_collections = ''
    @expired_auctionss = ''

    @bid = Bid.new
  end

  private

  def auction
    @auction = Auction.find(params[:auction_id])
  end

  def lot
    @lot = Lot.find(params[:id])
  end

  def lot_params
    params.require(:lot).permit(:title, :description, :quantity, :asking_price, :condition)
  end

  def correct_company
    return if current_company.id != @auction.company_id
  end
end

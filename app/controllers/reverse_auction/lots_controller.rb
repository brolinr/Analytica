# frozen_string_literal: true

class ReverseAuction::LotsController < ReverseAuction::ApplicationController
  before_action :permitted_access?, except: %i[wishlist wish show]
  before_action :lot, only: %i[show destroy wish]

  def show
    @bid = Bid.new
  end

  def create
    @lot = auction.lots.build(permitted_params)
    @lot.company = auction.company
    @lot.location = auction.location

    if @lot.save
      redirect_to edit_reverse_auction_auction_path(auction), flash: { notice: t('controllers.lots.create.success') }
    else
      redirect_to edit_reverse_auction_auction_path(auction), flash: { alert: t('controllers.lots.create.failure') }
    end
  end

  def destroy
    if lot.destroy
      redirect_to edit_reverse_auction_auction_path(auction), flash: { notice: t('controllers.lots.destroy.success') }
    else
      flash[:alert] = auction.errors.full_messages
    end
  end

  # rubocop:disable Metrics/PerceivedComplexity
  def wish
    collection = WatchedLot.find_by(company: current_company, lot: lot)

    if collection.is_a?(WatchedLot)
      if collection.destroy
        notice = t('controllers.lots.collect.removal')
      else
        alert = 'There was an error removing lot from wishlist. Try again!'
      end
    else
      collection = WatchedLot.new(company: current_company, lot: lot)
      if collection.save
        notice = t('controllers.lots.collect.collection')
      else
        alert = 'Something went wrong while whishlisting the lot. Try again'
      end
    end

    redirect_to request.referer, flash: { notice: notice || alert } if request.referer.present?
  end
  # rubocop:enable Metrics/PerceivedComplexity

  def wishlist
    @lots = current_company.collected_lots
    @bid = Bid.new
  end

  private

  def auction
    @auction = Auction.find(params[:auction_id])
  end

  def lot
    @lot = Lot.find(params[:id])
  end

  def permitted_access?
    unless auction.company_id == current_company.id
      redirect_to reverse_auction_auctions_path, flash: { notice: I18n.t('controllers.auctions.unauthorized') }
    end
  end

  def permitted_params
    params.require(:lot).permit(:title, :quantity, :asking_price, :condition)
  end
end

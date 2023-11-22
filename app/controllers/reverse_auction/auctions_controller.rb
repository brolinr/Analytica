# frozen_string_literal: true

class ReverseAuction::AuctionsController < ReverseAuction::ApplicationController
  before_action :permitted_access?, only: %i[edit update destroy extend_deadline]

  def new
    @auction = Auction.new
  end

  def create
    @auction = current_company.auctions.build(permitted_params)

    if @auction.save
      redirect_to edit_reverse_auction_auction_path(@auction), flash: { notice: I18n.t('controllers.auctions.create_success') }
    else
      flash[:alert] = resource.errors.full_messages.join(',')
      render :new
    end
  end

  def show
    @lots = auction.lots.order(:lot_number)
    @bid = Bid.new
  end

  def live
    @live_auctions = Auction.where(location: current_company.location, expired: false)
  end

  def buyer_auctions
    @buyer_auctions = Auction.where(company: current_company)
  end

  def registered
    registrations = AuctionRegistration.where(company_id: current_company.id).pluck(:auction_id)
    @registered_auctions = Auction.where(expired: false, id: registrations).order(deadline: :asc)
  end

  def edit
    @lot = Lot.new
    @lots = auction.lots
  end

  def update
    if auction.update(permitted_params)
      redirect_to edit_reverse_auction_auction_path(auction), flash: { notice: I18n.t('controllers.auctions.update_success') }
    else
      flash[:alert] = auction.errors.full_messages.join(',')
      render :edit
    end

  rescue StandardError
    flash[:alert] = I18n.t('controllers.something_wrong')
    render :edit
  end

  def destroy
    if auction.destroy!
      redirect_to reverse_auction_auctions_path, flash: { notice: I18n.t('controllers.auctions.delete_success') }
    else
      redirect_to request.referer, flash: { alert: auction.errors.full_messages.join(',') }
    end
  rescue StandardError
    redirect_to request.referer, flash: { alert: I18n.t('controllers.something_wrong') }
  end

  def extend_deadline
    if auction.update(deadline: auction.deadline.to_time + params[:auction][:extended_days].to_i.days)
      redirect_to edit_reverse_auction_auction_path(auction), flash: { notice: "The auction has been extended by #{params[:auction][:extended_days]} days." }
    else
      redirect_to request.referer, flash: { alert: I18n.t('controllers.something_wrong') }
    end
  end

  def register
    registration = AuctionRegistration.new(company_id: current_company.id, auction_id: auction.id)

    if registration.save
      redirect_to reverse_auction_auction_path(registration.auction), flash: { notice: I18n.t('controllers.auctions.register_success') }
    else
      redirect_to reverse_auction_auction_path(auction), flash: { alert: registration.errors.full_messages }
    end
  end


 private

  def auction
    @auction = Auction.find(params[:id] || params[:auction_id])
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = I18n.t('controllers.auctions.auction_not_found')
  end

  def company_is_buyer?
    flash[:alert] = I18n.t('controllers.auctions.company_not_buyer') unless current_company.buyer
  end

  def permitted_access?
    unless auction.company_id == current_company.id
      redirect_to reverse_auction_auctions_path, flash: { notice: I18n.t('controllers.auctions.unauthorized') }
    end
  end

  def permitted_params
    params.require(:auction).permit(
      :title, :description, :notes,
      :location, :start, :deadline,
      :image, :category_ids
    )
  end
end

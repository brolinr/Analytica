# frozen_string_literal: true

class AuctionsController < ApplicationController

  before_action :authenticate_company!
  before_action :permitted_params, only: %i[update create]
  before_action :auction, except: %i[create new index]
  before_action :buyer_user, except: %i[show index]
  before_action :access_correct_auction, only: %i[edit update destroy extend_deadline]
  before_action :expire_auctions, only: :index

  def new
    @auction = Auction.new
  end

  def create
    @auction = current_company.auctions.build(permitted_params)
    if @auction.save
      redirect_to edit_auction_path(@auction.id), flash: { notice: I18n.t('controllers.auctions.create_success') }
    else
      render :new
    end
    # NOTE: create job for notifications in future for all the companies in the region
  end

  def show
    @lots = auction.lots.order(:lot_number)
    @bid = Bid.new
  end

  def index; end

  def edit; end

  def update
    if auction.update(permitted_params)
      redirect_to edit_auction_path(auction), flash: { notice: I18n.t('controllers.auctions.update_success') }
    else
      flash[:error] = auction.errors.full_messages
      render :edit
    end
    # NOTE: create job for notifications in future if auction is live
  rescue StandardError
    flash[:error] = I18n.t('controllers.something_wrong')
    render :edit
  end

  def destroy
    if auction.destroy
      redirect_to auctions_path(auction), status: :ok, flash: { notice: I18n.t('controllers.auctions.delete_success') }
    else
      flash[:error] = auction.errors.full_messages
      render :edit
    end
    # NOTE: create job for notifications in future if the auction was still live
  rescue StandardError
    flash[:error] = I18n.t('controllers.something_wrong')
  end

  def extend_deadline
    if auction.update(deadline: auction.deadline.to_time + params[:auction][:extended_days].to_i.days)
      redirect_to edit_auction_path(auction),
                  flash: { notice: "The auction has been extended by #{params[:auction][:extended_days]} days." }
      # create job for notifications in future
    end
  end

  def register
    registration = AuctionRegistration.new(company_id: current_company.id, auction_id: auction.id)

    if registration.save
      # in future respond with turbo
      redirect_to auction_path(registration.auction), flash: { notice: I18n.t('controllers.auctions.register_success') }
    else
      redirect_to auction_path(auction), flash: { notice: registration.errors.full_messages }
    end
  end

  def company_profile; end

  def auctions_registered
    registered_auctions = AuctionRegistration.where(company_id: Company.last.id).pluck(:auction_id)

    @auctions = Auction.where(location: current_company.location, expired: false,
                              id: registered_auctions).order(deadline: :asc)
  end

  private

  def auction
    @auction = Auction.find(params[:id] || params[:auction_id])
  rescue ActiveRecord::RecordNotFound
    render :index
  end

  def permitted_params
    params.require(:auction).permit(:title, :description, :notes,
                                    :location, :start, :deadline,
                                    :image, :category_ids)
  end

  def buyer_user
    redirect_to auctions_path if current_company.nil? && !current_company.buyer
  end

  def access_correct_auction
    if @auction.company_id != current_company.id
      redirect_to auctions_path, flash: { notice: I18n.t('controllers.auctions.unauthorized') }
    end
  end

  def expire_auctions
    @auctions = Auction.where(location: current_company.location, expired: false).order(deadline: :asc)
    @auctions.each do |auction|
      auction.update!(expired: true) if auction.deadline.to_time < Time.current
    end
  end
end

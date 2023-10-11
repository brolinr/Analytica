# frozen_string_literal: true

class AuctionsController < ApplicationController
  before_action :authenticate_company!
  before_action :auction_params, only: %i[update create]
  before_action :auction, except: %i[create new index]
  before_action :buyer_user, except: %i[show index]
  before_action :access_correct_auction, only: %i[edit update destroy extend_deadline]
  before_action :expire_auctions, only: :index

  def new
    @auction = Auction.new
  end

  def create
    @auction = current_company.auctions.build(auction_params)
    if @auction.save
      redirect_to edit_auction_path(@auction.id),
                  flash: {
                    notice: 'Congratulations on creating
                             your auction. You can now add
                             lots to it.'
                  }
    else
      render :new
    end
    # create job for notifications in future for all the companies in the region
  end

  def show
    @lots = auction.lots.order(:lot_number)
    @bid = Bid.new
  end

  def index; end

  def edit; end

  def update
    if auction.update(auction_params)
      redirect_to edit_auction_path(auction),
                  flash: { notice: 'Your auction has been successfully updated.' }
    else
      flash[:error] = auction.errors.full_messages
      render :edit
    end
    # create job for notifications in future if auction is live
  rescue StandardError
    flash[:error] = 'There was an error while updating your auction.'
    render :edit
  end

  def destroy
    if auction.destroy
      redirect_to auctions_path(auction), status: :created,
                                          flash: { notice: 'The auction has been successfully deleted.' }
    else
      flash[:error] = auction.errors.full_messages
      render :edit
    end
    # create job for notifications in future if the auction was still live
  rescue StandardError
    flash[:error] = 'There was an error while deleting your auction.'
    render :edit
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
      redirect_to auction_path(registration.auction),
                  flash: { notice: 'Your registration has been approved. You can start bidding.' }
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
  end

  def auction_params
    params.require(:auction).permit(:title, :description, :notes,
                                    :location, :start, :deadline,
                                    :image, :category_ids)
  end

  def buyer_user
    redirect_to auctions_path if current_company.nil? && !current_company.buyer
  end

  def access_correct_auction
    if @auction.company_id != current_company.id
      redirect_to auctions_path, flash: { notice: 'You were not authorized to view that location!' }
    end
  end

  def expire_auctions
    @auctions = Auction.where(location: current_company.location, expired: false).order(deadline: :asc)
    @auctions.each do |auction|
      auction.update!(expired: true) if auction.deadline.to_time < Time.current
    end
  end
end

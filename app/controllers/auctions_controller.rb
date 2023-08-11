class AuctionsController < ApplicationController
  before_action :authenticate_company!, except: %i[show index]
  before_action :auction_params, only: %i[update create]
  before_action :auction, except: %i[create new index]
  before_action :buyer_user, except: %i[show index]
  before_action :access_correct_auction, only: %i[edit update destroy extend_deadline]
  before_action :expire_auctions, except: %i[create new index]

  def new
    @auction = Auction.new
  end

  def create
    @auction = current_company.auctions.build(auction_params)
    if @auction.save
      redirect_to auction_path(@auction), status: :created,
                                          flash: 'Congratulations on creating your auction. You can now add lots to it.'
    else
      flash[:error] = @auction.errors.full_messages
      render :new
    end
    #create job for notifications in future for all the companies in the region
  rescue StandardError
    flash[:error] = 'There was an error while creating your auction.'
    render :new
  end

  def show
    @lots = auction.lots.order(:id)
  end

  def index
    @auctions = Auction.where(location: current_company.location)
  end

  def edit; end

  def update
    if auction.update(auction_params)
      redirect_to auction_path(auction), status: :created,
                  flash: { notice:  'Your auction has been successfully updated.' }
    else
      flash[:error] = auction.errors.full_messages
      render :edit
    end
    #create job for notifications in future if auction is live
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
    #create job for notifications in future if the auction was still live
  rescue StandardError
    flash[:error] = 'There was an error while deleting your auction.'
    render :edit
  end

  def extend_deadline
    auction.deadline = auction.deadline.to_time + params[:extended_days].to_i.days

    if auction.save
      redirect_to auction_path(auction), flash: { notice: "The auction has been extended by #{params[:extended_days]} days." }
      #create job for notifications in future
    end
  end

  def register
    registration = AuctionRegistration.new(company_id: current_company.id, auction_id: auction.id)

    if registration.save
      #in future respond with turbo
      redirect_to auction_path(registration.auction), flash: { notice: 'Your registration has been approved. You can start bidding.' }
    else
      flash[:error] = registration.errors.full_messages
      render auction_path(auction)
    end
  rescue StandardError
    redirect_to auction_path(auction), flash: { notice: 'There was an error registering you for the auction.' }
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
    if @auction.id != current_company.id
      redirect_to auctions_path, flash: { notice: 'You were not authorized to view that location!' }
    end
  end

  def expire_auctions
    if @auction.deadline.to_time < Time.current
      @auction.update!(expired: true)
    end

    if @auction.expired?
      redirect_to auction_path(@auction), flash: { notice: 'This auction has expired!' }
    end
  end
end

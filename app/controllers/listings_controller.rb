class ListingsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_listing, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]

  def index
    @listings = Listing.all
  end

  def show
  end

  def new
    # Authorise only hosts to create events
    if current_user.is_host == false
      redirect_to root_path, notice: "I'm sorry, only hosts can create events!"
    else 
      @listing = Listing.new
    end
  end

  def edit
  end


  # Create new listing and redirect to that specific listing
  def create
    @listing = current_user.listings.build(listing_params)
    if @listing.save
      redirect_to @listing, notice: "Event created successfully!"
    else
      render :new 
    end 
  end

  def update
    if @listing.update(listing_params)
      redirect_to @listing, notice: "Event was successfully updated!"
    else
      render :edit, alert: "Your event wasn't updated"
    end 
  end 

  def correct_user
    if @listing.user != current_user
      redirect_to root_path
    end
  end 

  def destroy
    @listing.destroy

    redirect_to root_path, notice: "Your event was deleted"
  end 

  private

  def set_listing
    @listing = Listing.find(params[:id])
  end 

  def listing_params
    params.require(:listing).permit(:title, :description, :location, :date, :max_guests, :price, :user_id, :picture)
  end

end

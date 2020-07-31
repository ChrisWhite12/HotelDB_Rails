class ListingsController < ApplicationController
    before_action :print_params
    before_action :set_listing, only: [:show, :edit, :update, :destroy]
    # after_action :print_db

    def print_params
        p "***********"
        p params
        p "***********"
    end

    def print_db
        pp Listing.all
    end

    def new
        
    end

    def index
        #if a search, get params
        @listings = Listing.all
    end 

    def show
        @room_names = Room.where(listing_id: params[:id]).distinct.pluck(:name)
        @rooms = Room.where(listing_id: params[:id])
    end

    
    
    def edit
        @rooms = Room.where(listing_id: params[:id])
    end
    
    def update
        @listing.update(name: params[:listing][:name])
        @listing.update(location: params[:listing][:location])
        redirect_to listings_path
    end

    def create
        listing_params = params.require(:listing).permit(:name,:location)
        room_params = params.require(:room).permit(:name,:price,:no_people)
        days_params = params.require(:days_num).to_i
        
        #create the listing
        @listing = Listing.create(listing_params)

        #create the bookings
        for i in 0..days_params
            @booking = Booking.create(date: (Date.parse(params[:booking][:date]) + i), aval: true)
            pp @booking
            #create the rooms with links
            @room = Room.create(listing_id: @listing[:id], booking_id: @booking[:id])
            @room.update(room_params)
        end
        
        redirect_to listings_path
    end

    def destroy
        @listing.destroy
        redirect_to listings_path
    end

    private
    def set_listing
        id = params[:id]
        @listing = Listing.find(id)
    end
end
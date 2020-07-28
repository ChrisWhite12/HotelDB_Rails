class ListingsController < ApplicationController
    before_action :print_params
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
        @listings = Listing.all
    end 

    def show
        @listing = Listing.find(params[:id])
        @rooms = Room.where(listing_id: params[:id])
    end

    
    
    def edit
        @listing = Listing.find(params[:id])
    end
    
    def update
        list_update = Listing.find_by(id: (params[:id]).to_i)
        redirect_to listings_path
    end

    def create
        listing_params = params.require(:listing).permit(:name,:location)
        booking_params = params.require(:booking).permit(:date)
        room_params = params.require(:room).permit(:name,:price,:no_people)
        days_params = params.require(:days_num).to_i
        
        #create the listing
        @listing = Listing.create(listing_params)
        #create the bookings
        for i in 1..days_params
            @booking = Booking.create(booking_params)
            pp @booking
            #create the rooms with links
            @room = Room.create(listing_id: @listing[:id], booking_id: @booking[:id])
            @room.update(room_params)
        end
        

        redirect_to listings_path
    end

    def destroy
        list_del = Listing.find_by(id: (params[:id]).to_i)
        list_del.destroy
        redirect_to listings_path
    end
end
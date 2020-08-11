class RoomsController < ApplicationController
    load_and_authorize_resource
    before_action :set_search
    before_action :set_room, only: [:show, :edit, :update, :destroy]
    before_action :set_listing, only: [:new, :create]

    def show
        p params
        @bookings = Booking.where(room_id: params[:id])     #find booking of room
        pp @rooms
    end

    def new

    end
    
    def create
        days_params = params.require(:days_num).to_i        #require only days_num
        
        #create the rooms
        @room = Room.create(listing_id: @listing[:id], aval: true)
        @room.update(room_params)               #update using room_params

        for i in 0..days_params         #for i is 0 to the number of days
            #create bookings
            @booking = Booking.create(date: (Date.parse(params[:booking][:date]) + i), aval: true, room_id: @room[:id])
        end
        
        redirect_to listing_path(@listing[:id])     #redirect to listing
    end
    
    def edit
        @bookings = Booking.where(room_id: params[:id])     #find bookings of room
    end

    def update
        #update room values
        @room.update(name: params[:room][:name])
        @room.update(price: params[:room][:price])
        @room.update(no_people: params[:room][:no_people])
        redirect_to room_path(@room.id)     #redirect to show room
    end

    def destroy
        @room.destroy           #delete room
        redirect_to listings_path       #redirect to listing
    end

    private
    def set_listing
        #set listing from params
        id = params[:list_id]
        @listing = Listing.find(id)
        p '----///---'
        p @listing
    end
    def set_room
        #set room from params
        id = params[:id]
        @room = Room.find(id)
    end

    def room_params
        #permit room values
        params.require(:room).permit(:name,:price,:no_people)
    end

    def set_search
        #save search from cookies
        @search = session[:search]
    end
end
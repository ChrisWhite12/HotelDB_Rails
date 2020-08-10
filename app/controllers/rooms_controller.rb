class RoomsController < ApplicationController
    load_and_authorize_resource
    before_action :set_search
    before_action :set_room, only: [:show, :edit, :update, :destroy]
    before_action :set_listing, only: [:new, :create]
    def show
        p params
        @bookings = Booking.where(room_id: params[:id])
        pp @rooms
    end

    def new

    end
    
    def create
        days_params = params.require(:days_num).to_i
        
        #create the rooms
        @room = Room.create(listing_id: @listing[:id], aval: true)
        @room.update(room_params)

        for i in 0..days_params
            #create bookings
            @booking = Booking.create(date: (Date.parse(params[:booking][:date]) + i), aval: true, room_id: @room[:id])
        end
        
        redirect_to listing_path(@listing[:id])
    end
    
    def edit
        @bookings = Booking.where(room_id: params[:id])
    end

    def update
        @room.update(name: params[:room][:name])
        @room.update(price: params[:room][:price])
        @room.update(no_people: params[:room][:no_people])
        redirect_to room_path(@room.id)
    end

    def destroy
        @room.destroy
        redirect_to listings_path
    end

    private

    def set_listing
        id = params[:list_id]
        @listing = Listing.find(id)
        p '----///---'
        p @listing
    end
    def set_room
        id = params[:id]
        @room = Room.find(id)
    end
    def room_params
        params.require(:room).permit(:name,:price,:no_people)
    end

    def set_search
        @search = session[:search]
    end
end
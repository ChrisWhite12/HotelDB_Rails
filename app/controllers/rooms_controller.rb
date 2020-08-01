class RoomsController < ApplicationController

    def show
        p params
        @room = Room.find(params[:room_id])
        @bookings = Booking.where(room_id: params[:room_id])
        pp @rooms
    end

end
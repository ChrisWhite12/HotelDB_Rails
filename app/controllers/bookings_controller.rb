class BookingsController < ApplicationController
    
    def index
        @bookings = Booking.where(user_id: current_user[:id])
        pp @bookings
    end

    def show
        @bookings = Booking.where(user_id: current_user[:id])
    end

    def destroy

    end
end
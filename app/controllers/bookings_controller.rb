class BookingsController < ApplicationController
    load_and_authorize_resource
    
    def index
        #set bookings for current user
        @bookings = Booking.where(user_id: current_user[:id])
        pp @bookings
    end

    def show
        #set bookings for current user
        @bookings = Booking.where(user_id: current_user[:id])
    end
    
    private

    def booking_params
        #permit only date and aval
        params.require(:booking).permit(:date,:aval)
    end
end
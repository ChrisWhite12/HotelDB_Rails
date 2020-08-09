class BookingsController < ApplicationController
    load_and_authorize_resource

    def index
        @bookings = Booking.where(user_id: current_user[:id])
        pp @bookings
    end

    def show
        @bookings = Booking.where(user_id: current_user[:id])
    end

    def destroy

    end

    def booking_params
        params.require(:booking).permit(:date,:aval)
    end
end
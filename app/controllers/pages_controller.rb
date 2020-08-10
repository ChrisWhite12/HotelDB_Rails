class PagesController < ApplicationController
    before_action :set_profile, only: [:payment]

    def home

    end

    def search
        
    end

    def result

    end

    def payment
        @search = session[:search]
        @room = Room.find(params[:room_id])
        @date_from = @search["date_from"]
        @date_to = @search["date_to"]
    end

    def pay_confirm
        @room = Room.find(params[:room_id])
        @date_from = params[:date_from]
        @date_to = params[:date_to]
        
        for date_temp in 0...(@date_to.to_date - @date_from.to_date).to_i

            @booking = @room.bookings.find_by(date: (Date.parse(@date_from) + date_temp).to_s)
            @booking.update(aval: false)
            @booking.update(user_id: current_user[:id])
        end
    end

    def set_profile
        if user_signed_in?
            if Profile.find_by(user_id: current_user.id)
                @profile = Profile.find_by(user_id: current_user[:id])
                @address = @profile.address
                @payment = @profile.payment
            else
                redirect_to new_profile_path
            end
        else
            redirect_to new_user_session_path
        end
    end
end
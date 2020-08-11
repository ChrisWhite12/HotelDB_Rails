class PagesController < ApplicationController
    before_action :set_search
    before_action :set_profile, only: [:payment]

    def home

    end

    def payment
        @search = session[:search]                  #set search from cookies
        @room = Room.find(params[:room_id])         #set room as current room being booked
        @date_from = @search["date_from"]           #set date_from from @search  
        @date_to = @search["date_to"]               #set date_to from @search
    end

    def pay_confirm
        @room = Room.find(params[:room_id])         #set room to room that has been booked
        @date_from = params[:date_from]             #set date from params
        @date_to = params[:date_to]                 #set date from params
        
        for date_temp in 0...(@date_to.to_date - @date_from.to_date).to_i   #for the number of days between date_to and date_from

            @booking = @room.bookings.find_by(date: (Date.parse(@date_from) + date_temp).to_s)  #find the booking that matches date
            @booking.update(aval: false)                        #set avaliblity to false
            @booking.update(user_id: current_user[:id])         #set the user for the booking to current user
        end
    end

    def set_profile
        if user_signed_in?                      #if signed in
            if Profile.find_by(user_id: current_user.id)    #find profile of user
                @profile = Profile.find_by(user_id: current_user[:id])      #set @profile
                @address = @profile.address                                 #set @address
                @payment = @profile.payment                                 #set @payment
            else
                redirect_to new_profile_path                                #if can't find profile, redirect to new profile page
            end
        else
            redirect_to new_user_session_path                  #if not signed in, redirect to sign in
        end
    end

    def set_search
        @search = session[:search]              #set @search to 'search' in session cookies
        p "----]]]]----"
        pp @search
    end
end
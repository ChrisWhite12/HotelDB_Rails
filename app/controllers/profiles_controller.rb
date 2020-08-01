class ProfilesController < ApplicationController
# after_action :save_data, only: :new
    def index
        if user_signed_in? && !Profile.find_by(user_id: current_user[:id])
            p 'NEW INFO'
            redirect_to new_profile_path
        elsif !user_signed_in?
            redirect_to new_user_session_path
        end
    end

    def new
        @profile = Profile.new()
        @address = Address.new()
        @payment = Payment.new()
        p @payment
        p 'NEW'
    end

    def show

    end
    
    def edit

    end

    def save_data
        p 'SAVE DATA'
        @address.save
        @payment.save
        @profile.save

    end
end
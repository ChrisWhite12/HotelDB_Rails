class ProfilesController < ApplicationController
after_action: 
    def index
        if user_signed_in? && !Profile.find_by(user_id: current_user[:id])
            @profile = Profile.new()
            @address = Address.new()
            @payment = Payment.new()
            redirect_to new_profile_path
        elsif !user_signed_in?
            redirect_to new_user_session_path
        end
    end

    def show

    end
    
    def edit

    end
end
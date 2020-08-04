class PagesController < ApplicationController

    before_action :set_profile, only: [:payment]

    def home

    end

    def search
        
    end

    def result

    end

    def payment

    end

    def set_profile
        @profile = Profile.find_by(user_id: current_user[:id])
        @address = @profile.address
        @payment = @profile.payment
    end
end
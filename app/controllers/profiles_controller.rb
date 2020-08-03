class ProfilesController < ApplicationController
# after_action :save_data, only: :new
    def index
        if user_signed_in? && !Profile.find_by(user_id: current_user[:id])
            p 'NEW INFO'
            redirect_to new_profile_path
        elsif !user_signed_in?
            redirect_to new_user_session_path
        elsif user_signed_in? && Profile.find_by(user_id: current_user[:id])
            redirect_to profile_path(current_user[:id])
        end
    end

    def new
        @profile = Profile.new()
    end

    def create
        p "----------"
        p profile_params
        p profile_params[:payments]
        p profile_params[:address]

        @payment = Payment.create(profile_params[:payment])
        @address = Address.create(profile_params[:address])
        @profile = Profile.create(fname: profile_params[:fname], lname: profile_params[:lname], phone: profile_params[:phone], address_id: @address.id, payment_id: @payment.id, user_id: current_user.id, role: "customer")
        # @profile = Profile.create([profile_params, role: "customer"])
        redirect_to root_path
    end

    def show
        @profiles = Profile.all()
        pp @profiles
        @profile = Profile.find(params[:id])
    end
    
    def edit
        @profile = Profile.find(params[:id])
        @address = @profile.address
        @payment = @profile.payment
        pp @address
    end

    def profile_params
        params.require(:profile).permit(:fname, :lname, :phone, address:[:street_no, :street_name, :suburb, :state, :postcode], payment: [:card_no, :card_name, :CSV, :expiry])
    end
end
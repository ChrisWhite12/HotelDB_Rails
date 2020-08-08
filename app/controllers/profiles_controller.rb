class ProfilesController < ApplicationController
    before_action :set_profile, only: [:show, :edit, :update, :destroy]
    
    def index
        if user_signed_in? && !Profile.find_by(user_id: current_user[:id])
            p 'NEW INFO'
            redirect_to new_profile_path
        elsif current_user[:admin] == 2
            @profiles = Profile.all()
        elsif !user_signed_in?
            redirect_to new_user_session_path
        elsif user_signed_in? && Profile.find_by(user_id: current_user[:id]) && current_user[:admin] != 2
            redirect_to profile_path(Profile.find_by(user_id: current_user[:id]).id)
        
        end
    end

    def new
        p "*****************************************"
        p "Inside new method just rendering the form"
        @profile = Profile.new()
        @address = Address.new()
        @payment = Payment.new()
        @user = User.new()
    end

    def create
        p "----------"
        p profile_params
        p profile_params[:payments]
        p profile_params[:address]

        @payment = Payment.create(profile_params[:payment])
        @address = Address.create(profile_params[:address])
        @profile = Profile.create(fname: profile_params[:fname], lname: profile_params[:lname],
        phone: profile_params[:phone], address_id: @address.id, payment_id: @payment.id, user_id: current_user.id)
        redirect_to root_path
    end

    def show
        @profiles = Profile.all()
        pp @profiles
    end
    
    def edit
        
    end

    def update
        
        @payment.update(profile_params[:payment])
        @address.update(profile_params[:address])
        @profile.update(fname: profile_params[:fname], lname: profile_params[:lname], phone: profile_params[:phone])
        
        if can? :edit, User
            @user.update(profile_params[:user])
        end
        redirect_to root_path
    end

    def profile_params
        params.require(:profile).permit(:fname, :lname, :phone,
            address:[:street_no, :street_name, :suburb, :state, :postcode],
            payment:[:card_no, :card_name, :CSV, :expiry],
            user:[:admin]
        )
    end

    def set_profile
        @profile = Profile.find(params[:id])
        @address = @profile.address
        @payment = @profile.payment
        @user = @profile.user
    end

end
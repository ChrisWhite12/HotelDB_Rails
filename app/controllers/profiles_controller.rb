class ProfilesController < ApplicationController
    # load_and_authorize_resource
    before_action :set_search
    before_action :set_profile, only: [:show, :edit, :update, :destroy]
    
    def index
        if user_signed_in? && !Profile.find_by(user_id: current_user[:id])      #if no profile
            p 'NEW INFO'
            redirect_to new_profile_path            #redirect to new profile page
        elsif current_user[:admin] == 3             #if admin
            @profiles = Profile.all()               #set @profiles to show all profiles
        elsif !user_signed_in?                      #not signed in
            redirect_to new_user_session_path       #redirect to sign in
        elsif user_signed_in? && Profile.find_by(user_id: current_user[:id]) && current_user[:admin] != 3   #if not admin and has profile
            redirect_to profile_path(Profile.find_by(user_id: current_user[:id]).id)    #redirect to current user profile
        end
    end

    def new
        #set new objects for variables to create new form 
        @profile = Profile.new()
        @address = Address.new()
        @payment = Payment.new()
        @user = current_user
    end

    def create
        #create new payment entry
        @payment = Payment.create(profile_params[:payment])
        #create new address entry
        @address = Address.create(profile_params[:address])
        #create new profile entry, linking address and payment
        @profile = Profile.create(fname: profile_params[:fname], lname: profile_params[:lname],
        phone: profile_params[:phone], address_id: @address.id, payment_id: @payment.id, user_id: current_user.id)
        #redirect to home
        redirect_to root_path
    end

    def show
        @profiles = Profile.all()   #set @profiles to show all profiles for admin
    end
    
    def edit
        
    end

    def update
        #update payment entry
        @payment.update(profile_params[:payment])
        #update address entry
        @address.update(profile_params[:address])
        #update profile entry
        @profile.update(fname: profile_params[:fname], lname: profile_params[:lname], phone: profile_params[:phone])
        
        if can? :edit, User         #if can edit user (admin)
            @user.update(profile_params[:user])     #update user
        end

        redirect_to profile_path(@profile.id)       #redirect to profile show (current user)
    end

    private
    
    def profile_params
        #set permited variables
        params.require(:profile).permit(:fname, :lname, :phone, address: [:street_no, :street_name, :suburb, :state, :postcode],
        payment: [:card_no, :card_name, :CSV, :expiry],
        user: [:admin]
        )
    end

    def set_profile
        #set variables to params(id)
        @profile = Profile.find(params[:id])
        @address = @profile.address
        @payment = @profile.payment
        @user = @profile.user
    end

    def set_search
        #set search from cookies
        @search = session[:search]
    end
end
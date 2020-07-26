class ListingsController < ApplicationController
    before_action :print_params
    # after_action :print_db

    def print_params
        p "***********"
        p params
        p "***********"
    end

    def print_db
        pp Listing.all
    end

    def new
        
    end

    def index
        @listings = Listing.all
    end 

    def show
        @listing = Listing.find(params[:id])
    end

    
    
    def edit
        @listing = Listing.find(params[:id])
    end
    
    def update
        list_update = Listing.find_by(id: (params[:id]).to_i)
        list_update.update(fname: params[:listing][:fname])
        list_update.update(lname: params[:listing][:lname])
        redirect_to listings_path
    end

    def create
        # @listing = listing.new(params[:listing])
        @listing = listing.create([
        fname: params[:listing][:fname],
        lname: params[:listing][:lname]]
        )
        redirect_to listings_path
    end

    def destroy
        list_del = Listing.find_by(id: (params[:id]).to_i)
        list_del.destroy
        redirect_to listings_path
    end
end
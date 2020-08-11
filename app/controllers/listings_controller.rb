class ListingsController < ApplicationController
    load_and_authorize_resource
    before_action :set_search
    before_action :print_params
    before_action :set_listing, only: [:show, :edit, :update, :destroy]
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
        @listing = Listing.new()
    end

    def create

        #create the listing
        @listing = Listing.create(listing_params)
        @listing.update(user_id: current_user[:id])
        
        redirect_to listings_path
    end

    def index
        session[:search] = {}
        
        #if a search, get params
        if params[:search] != nil
            #check params
            if (params[:search][:location] != '' && params[:search][:no_people] != '' &&
            params[:search][:date_from] != '' && params[:search][:date_to] != '')
                #check if the dates are valid
                if (Date.parse(params[:search][:date_to]) - Date.parse(params[:search][:date_from])) >= 1
                    session[:search] = search_params
                    @listings = Listing.where(location: params[:search][:location].downcase.capitalize)
                else
                    p 'wrong dates'
                    redirect_to root_path
                end
            else
                p 'incomplete search'
                redirect_to root_path
            end
        else
            @listings = Listing.where(user_id: current_user.id)
        end
    end 

    def show
        @search = session[:search]
        p "cookie - search"
        pp @search
        p @search['no_people']
        
        @booking_text = ""

        if @search != {}
            @rooms_list = Room.where("listing_id = ? AND no_people = ?", params[:id], @search["no_people"].to_i)
            @rooms = []
            @rooms_list.each{|r|
                if date_aval(r,@search["date_from"],@search["date_to"])
                    @rooms.push(r)
                    p "pushed #{r}"
                end
            }
            @booking_text = "Book for #{@search["date_from"]} - #{@search["date_to"]}"
        else
            @rooms = Room.where(listing_id: params[:id])
        end

        
    end

    
    
    def edit
        @rooms = Room.where(listing_id: params[:id])
    end
    
    def update
        @listing.update(name: params[:listing][:name])
        @listing.update(location: params[:listing][:location])
        redirect_to listings_path
    end



    def destroy
        @listing.destroy
        redirect_to listings_path
    end

    def date_aval(room, date_from, date_to)
        for i in 1..room.bookings.length
            booking_temp = room.bookings.find_by(date: date_from)
            p booking_temp
            if booking_temp[:aval]
                if date_from == date_to
                    return true
                else
                    date_from = (Date.parse(date_from) + 1).to_s
                end
            else
                return false
            end
        end

    end

    private
    def set_listing
        id = params[:id]
        @listing = Listing.find(id)
    end

    def listing_params
        params.require(:listing).permit(:name,:location,:picture)
    end

    def room_params
        params.require(:room).permit(:name,:price,:no_people)
    end

    def search_params
        params.require(:search).permit(:location, :no_people, :date_from, :date_to)
    end

    def set_search
        @search = session[:search]
        p "----]]]]----"
        pp @search
    end
end
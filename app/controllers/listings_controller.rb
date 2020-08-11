class ListingsController < ApplicationController
    load_and_authorize_resource
    before_action :set_search
    before_action :print_params
    before_action :set_listing, only: [:show, :edit, :update, :destroy]

    def print_params
        p "***********"
        p params
        p "***********"
    end

    def new
        @listing = Listing.new()        #create new listing entry
    end

    def create
        #create the listing
        @listing = Listing.create(listing_params)
        @listing.update(user_id: current_user[:id])     #update user id
        
        redirect_to listings_path       #redirect to listing
    end

    def index
        session[:search] = {}           #clear search cookie
    
        if params[:search] != nil   #if a search
            #check params
            if (params[:search][:location] != '' && params[:search][:no_people] != '' &&
            params[:search][:date_from] != '' && params[:search][:date_to] != '')
                #check if the dates are valid
                if (Date.parse(params[:search][:date_to]) - Date.parse(params[:search][:date_from])) >= 1
                    session[:search] = search_params                                                        #save search params to cookies
                    @listings = Listing.where(location: params[:search][:location].downcase.capitalize)     #set listings that match location
                else
                    p 'wrong dates'
                    redirect_to root_path           #if date invalid, redirect to home
                end
            else
                p 'incomplete search'
                redirect_to root_path               #if not all search input filled in, redirect to home
            end
        else
            #if not search, list all listing for current user (seller)
            @listings = Listing.where(user_id: current_user.id)
        end
    end 

    def show
        @search = session[:search]          #set search from cookies
        p "cookie - search"
        pp @search
        p @search['no_people']
        
        @booking_text = ""                  #clear booking text

        if @search != {}                    #if a search
            #set rooms that match conditions
            @rooms_list = Room.where("listing_id = ? AND no_people = ?", params[:id], @search["no_people"].to_i)
            @rooms = []
            @rooms_list.each{|r|
                #push to @rooms if avaliable on all dates in query
                if date_aval(r,@search["date_from"],@search["date_to"])
                    @rooms.push(r)
                    p "pushed #{r}"
                end
            }
            @booking_text = "Book for #{@search["date_from"]} - #{@search["date_to"]}" #set booking text
        else
            @rooms = Room.where(listing_id: params[:id])        #if not search, set to all rooms of listing
        end
    end

    
    
    def edit
        @rooms = Room.where(listing_id: params[:id])            #set rooms of current listing
    end
    
    def update
        #update listing
        @listing.update(name: params[:listing][:name])       
        @listing.update(location: params[:listing][:location])
        redirect_to listings_path                               #redirect to listing
    end



    def destroy
        @listing.destroy                    #delete listing
        redirect_to listings_path           #redirect to listing index
    end

    def date_aval(room, date_from, date_to)                 #check if avaliable between dates
        for i in 1..room.bookings.length                    #for all booking in room
            booking_temp = room.bookings.find_by(date: date_from)   #set booking_temp to booking on date_from
            p booking_temp
            if booking_temp[:aval]                          #check if booking avaliable on date  
                if date_from == date_to                     #if date_from is equal to date_to
                    return true                             #return true (avaliable between dates)
                else
                    date_from = (Date.parse(date_from) + 1).to_s        #increment date_from if not matching
                end
            else
                return false                    #if booking not avaliable
            end
        end

    end

    private
    def set_listing
        #set listing by id
        id = params[:id]
        @listing = Listing.find(id)
    end

    def listing_params
        #permit listing params
        params.require(:listing).permit(:name,:location,:picture)
    end

    def room_params
        #permit room params
        params.require(:room).permit(:name,:price,:no_people)
    end

    def search_params
        #permit search params
        params.require(:search).permit(:location, :no_people, :date_from, :date_to)
    end

    def set_search
        @search = session[:search]
        p "----]]]]----"
        pp @search
    end
end
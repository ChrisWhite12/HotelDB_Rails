class ListingsController < ApplicationController
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
        
    end

    def index
        session[:search] = {}
        
        #if a search, get params
        if params[:search] != nil
            session[:search] = search_params
            @listings = Listing.where(location: params[:search][:location].downcase.capitalize)
        else
            @listings = Listing.all
        end
    end 

    def show
        @search = session[:search]
        p "cookie - search"
        pp @search
        p @search['no_people']
        # @rooms = Rooms.where(no_people: params[:search][:no_people])
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

    def create
        listing_params = params.require(:listing).permit(:name,:location)
        room_params = params.require(:room).permit(:name,:price,:no_people)
        days_params = params.require(:days_num).to_i
        
        #create the listing
        @listing = Listing.create(listing_params)
        #create the rooms
        @room = Room.create(listing_id: @listing[:id], aval: true)
        @room.update(room_params)

        for i in 0..days_params
            #create bookings
            @booking = Booking.create(date: (Date.parse(params[:booking][:date]) + i), aval: true, room_id: @room[:id])
        end
        
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

    def search_params
        params.require(:search).permit(:location, :no_people, :date_from, :date_to)
    end
end
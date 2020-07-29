class RoomsController < ApplicationController

    def show
        p params
        @rooms = Room.where("name = ? AND listing_id = ? ", params[:room_name], params[:id])
        pp @rooms
    end

end
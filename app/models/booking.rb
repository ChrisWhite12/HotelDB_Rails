class Booking < ApplicationRecord
    # has_many :rooms
    # has_many :listings, through: :rooms
    belongs_to :room
end

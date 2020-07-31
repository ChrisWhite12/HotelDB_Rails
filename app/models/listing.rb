class Listing < ApplicationRecord
    # has_many :rooms, dependent: :destroy
    has_many :rooms
    # has_many :bookings, through: :rooms
end

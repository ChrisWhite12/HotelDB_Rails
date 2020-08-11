class Room < ApplicationRecord
    belongs_to :listing
    has_many :bookings, dependent: :destroy
end

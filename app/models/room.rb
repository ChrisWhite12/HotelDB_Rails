class Room < ApplicationRecord
    belongs_to :listing
    # belongs_to :booking
    has_many :bookings, dependent: :destroy
end

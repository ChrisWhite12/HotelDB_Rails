class Booking < ApplicationRecord
    # has_many :rooms
    # has_many :listings, through: :rooms
    belongs_to :room
    belongs_to :user, optional: true

    def start_time
        self.date
    end
end

class Booking < ApplicationRecord
    belongs_to :room
    belongs_to :user, optional: true

    def start_time
        self.date
    end
end

class Listing < ApplicationRecord
    has_many :rooms
    has_one_attached :picture
end

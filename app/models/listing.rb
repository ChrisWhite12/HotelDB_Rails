class Listing < ApplicationRecord
    has_many :rooms, dependent: :destroy
    belongs_to :user
    accepts_nested_attributes_for :rooms
    
    has_one_attached :picture
end

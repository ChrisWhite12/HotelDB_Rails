class Listing < ApplicationRecord
    has_many :rooms, dependent: :destroy
    has_one_attached :picture, dependent: :destroy
    belongs_to :user
end

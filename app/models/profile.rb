class Profile < ApplicationRecord
  belongs_to :payment
  belongs_to :address
  belongs_to :user
end

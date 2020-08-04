class Profile < ApplicationRecord
  belongs_to :payment 
  belongs_to :address
  belongs_to :user
  # Changes by Varsha
  accepts_nested_attributes_for :payment
  accepts_nested_attributes_for :address 
  # End of changes by Varsha
end
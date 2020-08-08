class Profile < ApplicationRecord
  belongs_to :payment 
  belongs_to :address
  belongs_to :user
  
  accepts_nested_attributes_for :payment
  accepts_nested_attributes_for :address 
  accepts_nested_attributes_for :user
end
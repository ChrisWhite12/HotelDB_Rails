Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  #main page
  get "/", to: "listings#index", as:"root"
  #Show all listings
  # get "/listing", to: "listings#index", as: "listings"
  #create listing
  get "/listing/new", to: "listings#new", as: "new_listing"
  #show listing
  get "/listing/:id", to: "listings#show", as: "listing"
  #create listing
  post "/listing", to: "listings#create", as: "create_listing"
  #delete listing
  delete "/listing/:id", to: "listings#destroy", as: "delete_listing"


end

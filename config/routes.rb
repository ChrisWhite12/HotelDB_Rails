Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  #Show all listings
  get "/listing", to: "listings#index", as: "listings"
  #create listing
  get "/listings/new", to: "listings#new", as: "new_listing"
  #show listing
  get "/listings/:id", to: "listings#show", as: "listing"
  #create listing
  post "/listings", to: "listings#create", as: "create_listing"
  #delete listing
  delete "/listings/:id", to: "listings#destroy", as: "delete_listing"

  #pages
  get "/", to: "pages#home", as:"root"
  #results
  get "/search", to: "pages#search", as:"search"

end

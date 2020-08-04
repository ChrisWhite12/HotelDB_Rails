Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  #pages
  get "/", to: "pages#home", as:"root"

  #Show all listings
  get "/listings", to: "listings#index", as: "listings"
  #create listing
  get "/listings/new", to: "listings#new", as: "new_listing"
  #show listing
  get "/listings/:id", to: "listings#show", as: "listing"
  #edit listing
  get "/listings/:id/edit", to: "listings#edit", as: "edit_listing"
  #create listing
  post "/listings", to: "listings#create", as: "create_listing"
  #update listing
  patch "/listings/:id", to: "listings#update", as: "update_listing"
  #delete listing
  delete "/listings/:id", to: "listings#destroy", as: "delete_listing"

  #new rooms
  get "/rooms/new/:list_id", to: "rooms#new", as: "new_room"
  #create room
  post "/rooms/:list_id", to: "rooms#create", as: "create_room"
  #show room
  get "/rooms/:id", to: "rooms#show", as: "room"
  #edit room
  get "/rooms/:id/edit", to: "rooms#edit", as: "edit_room"
  #update room
  patch "/rooms/:id", to: "rooms#update", as: "update_room"
  #delete room
  delete "/rooms/:id", to: "rooms#destroy", as: "delete_room"

  #bookings
  get "/bookings", to: "bookings#index", as: "bookings"  

  #profile
  get "/profiles", to: "profiles#index", as: "profiles"
  #new profile
  get "/profiles/new", to: "profiles#new", as:"new_profile"
  #view profile
  get "/profiles/:id", to: "profiles#show", as: "profile"
  #edit profile
  get "/profiles/:id/edit", to: "profiles#edit", as: "edit_profile"
  #update profile
  patch "/profiles/:id", to: "profiles#update", as: "update_profile"
  #create profile
  post "/profiles", to: "profiles#create", as:"create_profile"

  get "/pages/payment", to: "pages#payment", as: "payment_page"
  get "/payments", to: "payments#index", as: "payments"

  get "/addresses", to: "addresses#index", as: "addresses"

end

Rails.application.routes.draw do

  devise_for :users
  get "/", to: "pages#index", as: "root"
  
  # Profiles routes
  resources :profiles
  # Listings routes
  resources :listings
  # Bookings routes
  resources :bookings
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
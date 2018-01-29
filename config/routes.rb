require 'sidekiq/web'

Rails.application.routes.draw do
  resources :special_prices
  get 'bookings/cancel_booking'
  get 'bookings/unconfirmed_bookings'
  get 'rooms/my_rooms'
  get 'rooms/unauthorized_rooms'
  resources :cities
  devise_for :users
  resources :rooms
  resources :reviews
  resources :amenities
  resources :bookings
  get 'say/hello'
  root 'say#hello'
  mount Sidekiq::Web => '/sidekiq'


  # resources :rooms do
  #   resources :special_prices
  # end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

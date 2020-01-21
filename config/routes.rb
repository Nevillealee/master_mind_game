require 'resque/server'
Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  mount Resque::Server.new, :at => "/resque"
  root 'games#home'
  resources :games, only: [:index, :show, :update]
  get '/games/home', to: 'games#home'
  resources :users, only: [:index, :new, :create]
end

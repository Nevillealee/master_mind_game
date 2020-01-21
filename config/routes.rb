require 'resque/server'
Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  mount Resque::Server.new, :at => "/resque"
  root 'games#index'
  resources :games, only: :index
  get '/games/start', to: 'games#start'
  resources :users, only: [:index, :new, :create]
end

Rails.application.routes.draw do
  resources :styles
  resources :memberships
  resources :beer_clubs
  resources :users
  resources :beers
  resources :breweries
  resources :ratings, only: [:index, :new, :create, :destroy]
  resource :session, only: [:new, :create, :destroy]
  resources :places, only:[:index, :show]
  resources :breweries do
    post 'toggle_activity', on: :member
  end
  resources :users do
    post 'change_block', on: :member
  end
  root 'breweries#index'
  post 'places', to:'places#search'
  get 'signup', to: 'users#new'
  get 'signin', to: 'sessions#new'
  delete 'signout', to: 'sessions#destroy'

  get 'auth/:provider/callback', to: 'sessions#create_oauth'

  get 'beerlist', to:'beers#list'
  get 'brewerylist', to:'breweries#list'
end
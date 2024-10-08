Rails.application.routes.draw do
  root to: "static#home"
  resources :sessions, only: [:create]
  delete :logout, to: "sessions#logout"
  get :logged_in, to: "sessions#logged_in"
  resources :registrations, only: [:create]
  resources :posts, only: [:create, :index]
  resources :friendships, only: [:create, :destroy]
end
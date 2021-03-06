# frozen_string_literal: true

Rails.application.routes.draw do
  get 'sessions/new'
  get 'users/new'
  root 'static_pages#home'
  get 'static_pages/home'
  get '/signup', to: 'users#new'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  resources :users do
    member do
      get :following, :followers, :likes, :goods, :microposts, :records
    end
  end
  resources :microposts, only: %i[new create destroy edit update index] do
    resources :comments, only: %i[create index]
    resources :books, only: %i[create]
  end
  resources :books do
    collection do
      get :ranking
    end
  end

  resources :bookshelves do
    resources :records
  end

  resources :likes
  resources :statuses
  resources :records
  resources :bookshelves
  resources :comments, only: %i[edit update destroy]
  resources :relationships, only: %i[create destroy]
  resources :likes, only: %i[create destroy]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

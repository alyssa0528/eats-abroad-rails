Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'application#home'
  get '/signin' => 'sessions#new'
  post '/signin' => 'sessions#create'
  get '/auth/facebook/callback' => 'sessions#create'

  delete '/signout' => 'sessions#destroy'
  resources :cities, only: [:index]
  resources :cities, only: [:show] do
    resources :restaurants, only: [:index, :show]
  end

  resources :restaurants, only: [:index, :show, :new, :create]

  resources :chefs, only: [:index, :new, :create, :show, :edit, :update]
  resources :chefs, only: [:show] do
    resources :restaurants, only: [:index, :show, :new]
  end

  resources :restaurants, only: [:show] do
    resources :comments, only: [:new, :create, :show, :edit]
  end 
end

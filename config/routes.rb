Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'application#home'
  resources :cities, only: [:index, :show]
  resources :restaurants, only: [:index, :show, :new, :create]
end

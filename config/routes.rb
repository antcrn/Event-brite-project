Rails.application.routes.draw do
  root to: 'events#index'   
  get 'static_pages/secret', to:"static_pages#secret"  
  resources :events
  devise_for :users
  resources :users, :only => [:show]
  resources :orders, :only => [:index, :new, :create]
  resources :attendances, :only => [:show, :new, :create]

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

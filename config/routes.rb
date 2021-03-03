Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users, only: [:new, :index, :create, :show]
  resources :attractions, only: [:index, :show, :new, :create, :edit, :update]
  resources :rides, only: [:create]
  get '/signin' => 'sessions#new'
  get '/signup' => 'users#new'
  
  post '/session' => 'sessions#create'
  delete '/session' => 'sessions#destroy'
  root 'static#home' # 
end

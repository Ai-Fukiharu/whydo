Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'toppages#index'
  
  get 'signup', to: 'users#new'
  resources :users, only:[:show, :new, :create, :edit, :update]
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  resources :ambitions, only:[:show, :new, :create, :edit, :update, :destroy]
  
  get '/ambitions/:id/key_results/new', to: 'key_results#new'
  resources :key_results, only:[:create, :edit, :update, :destroy]
  
  get '/key_results/:id/daily_results/new', to: 'daily_results#new'
  resources :daily_results, only:[:create, :edit, :update, :destroy]
end

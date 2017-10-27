Rails.application.routes.draw do
  
  get 'help' => 'static_pages#help'
  get 'about' => 'static_pages#about'
  get 'signup' => 'users#new'
  post 'signup' => 'users#create'
  
  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'
  
  resources :users, except: [:new, :create]
  
  root 'static_pages#home'
end

Rails.application.routes.draw do
  get 'session/new'
  get '/signup', to: "users#new"
  get '/help', to: 'stactic_pages#help'
  get '/about', to: 'stactic_pages#about'
  get '/contact', to: 'stactic_pages#contact'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root 'stactic_pages#home'
  resources :account_actives , only: [:edit]   #/account_active/:token/edit
  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :relationships, only: [:create, :destroy]
  resources :microposts , only: [:create, :destroy]
  get '/login', to: 'session#new'
  post '/login', to: 'session#create'
  delete '/logout', to: 'session#destroy'
  # Defines the root path route ("/")
  # root "articles#index"
  
end

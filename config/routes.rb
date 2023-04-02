Rails.application.routes.draw do
  get 'achievements/index', as: 'achs'
  get 'about_us/index', as: 'about_us'
  resources :tasks
  resources :contests
  resources :weeks
  root to: 'posts#index'

  resources :posts
  get    '/login',  to: 'session#new',     as: 'login'
  post   '/login',  to: 'session#create',  as: 'session_create'
  get    '/logout', to: 'session#destroy', as: 'logout'
  resources :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end

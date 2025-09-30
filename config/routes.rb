Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  root 'pages#landing'

  resources :users
  resources :posts do
    resources :comments, only: [:create, :destroy]
  end

  get 'up' => 'rails/health#show', as: :rails_health_check

  get 'index', to: 'posts#index'
  get 'landing', to: 'pages#landing'
  get 'home', to: 'pages#home'

  # Defines the root path route ("/")
end

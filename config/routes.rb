Rails.application.routes.draw do
  root "pages#main"
  get 'auth/:provider/callback' => "accounts#create"
  get 'login' => "sessions#new"
  post 'login' => "sessions#create"
  get 'logout' => "sessions#destroy"
  resources :users do
    resources :accounts, only: [:destroy]
  end

  resources :societies
end

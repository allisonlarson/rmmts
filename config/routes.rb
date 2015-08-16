Rails.application.routes.draw do
  root "pages#main"
  get 'auth/:provider/callback' => "accounts#create"
  get 'login' => "sessions#new"
  post 'login' => "sessions#create"
  get 'logout' => "sessions#destroy"
  resources :users
  resources :societies
end

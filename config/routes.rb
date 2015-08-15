Rails.application.routes.draw do
  root "pages#main"
  get 'auth/:provider/callback' => "sessions#create"
  resources :users, only: [:show]
end

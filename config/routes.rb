Rails.application.routes.draw do
  root "pages#main"
  get 'auth/:provider/callback' => "accounts#create"
  post 'society' => "pages#society"
  get 'login' => "sessions#new"
  post 'login' => "sessions#create"
  get 'logout' => "sessions#destroy"

  resources :societies, :path => '', :only => [:new, :create]

  resources :societies, :path => '', :only => [] do
    get "/account" => "users#show", as: "user"
    get "/account/edit" => "users#edit", as: "edit_user"

    delete "/account/payments/:id" => "accounts#destroy", as: "user_account"

    resources :users, :path => '', except: [:index, :show, :edit]
  end
end

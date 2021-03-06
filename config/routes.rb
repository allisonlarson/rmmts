Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "registrations"}
  root to: "pages#main"
  get 'auth/:provider/callback' => "accounts#create"
  post 'society' => "pages#society"

  resources :societies, :path => '', :only => [:new, :create]

  resources :societies, :path => '', :only => [] do
    get "/account" => "users#show", as: "user"
    get "/account/edit" => "users#edit", as: "edit_user"
    delete "/account/payment_account/:id" => "accounts#destroy", as: "user_account"
    post "/account/pay" => "users#pay", as: "user_pay"

    resources :users, :path => '', except: [:index, :show, :edit] do
      resources :payments do
        post "/pay" => "payments#pay"
      end
    end

    resources :expenses
  end
end

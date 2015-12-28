Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "registrations"}
  root to: "pages#main"
  get 'auth/:provider/callback' => "accounts#create"
  post 'search' => "pages#society"
  get 'account' => 'users#show'
  get 'account/edit' => 'users#edit'

  resources :societies do

    resources :users do
      resources :payments do
        post "/pay" => "payments#pay"
      end

      resources :accounts, path: "payment_accounts" do
        post "/pay" => "accounts#pay"
      end
    end

    resources :expenses
  end
end

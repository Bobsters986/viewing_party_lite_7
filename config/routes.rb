Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  root to: "home#index"

  get "/register", to: "users#new"
  post "/register", to: "users#create"

  resource :user, only: %i[show], path: '/dashboard' do
    resources :discover, only: [:index]
    resources :movies, only: %i[index show] do
      resources :viewing_party, only: [:new, :create], controller: 'parties'
    end
  end

  namespace :admin do
    resources :dashboard, only: [:index]
    resources :users, only: [:show]
  end

  resources :sessions, only: [:new, :create, :destroy]
  # get "/login", to: "users#login_form"
  # post "/login", to: "users#login_user"
  # delete "/logout", to: "users#logout"
end

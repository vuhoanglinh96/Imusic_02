Rails.application.routes.draw do
  get 'users/show'

  devise_for :users, controllers: {
    sessions: "users/sessions",
    registrations: "users/registrations"
  }
  root "pages#show", page: "index"

  get "/pages/:page" => "pages#show"

  resources :tracks, only: [:new, :create, :show]
  resources :users, only: :show
end

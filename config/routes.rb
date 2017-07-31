Rails.application.routes.draw do
  get 'users/show'

  devise_for :users, controllers: {
    sessions: "users/sessions",
    registrations: "users/registrations"
  }
  root "pages#show", page: "index"

  get "/pages/:page" => "pages#show"
  get "/types/:type" => "types#show"

  resources :tracks, except: [:index, :edit, :destroy]
  resources :users, only: :show
  resources :genres, only: :show
end

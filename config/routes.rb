Rails.application.routes.draw do
  root "pages#show", page: "index"

  get "/pages/:page" => "pages#show"

  resources :tracks, only: [:new, :create]
end

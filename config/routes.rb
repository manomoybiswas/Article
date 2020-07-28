Rails.application.routes.draw do
  get 'sessions/new'
  root "home#index"
  get :overview, "home/overview"
  resources :users
  resources :sessions
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

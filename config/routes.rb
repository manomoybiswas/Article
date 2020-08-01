Rails.application.routes.draw do
  require "sidekiq/web"

  root "home#index"
  get :overview, "home/overview"
  get :about_us, "home/about_us"
  get :contact_us, "home/contact_us"
  resources :users do
  end
  resources :sessions
  resources :posts do
    resources :comments, only: [:create, :index, :new]
    member do
      put :like
    end
    collection do
      get :refresh_comment
      get :search
      get :print_pdf
      get :filtered_posts
    end
  end
  resources :comments do
    member do
      put :comment_like
    end
  end
  resources :categories
  resources :change_passwords
  resources :password_resets

  mount Sidekiq::Web, at: "/sidekiq"
end

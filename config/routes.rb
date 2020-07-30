Rails.application.routes.draw do
  root "home#index"
  get :overview, "home/overview"
  resources :users
  resources :sessions
  resources :posts do
    resources :comments, only: [:create, :index, :new]
    member do
      put :like
    end
    collection do
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
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

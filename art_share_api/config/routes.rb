Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  resources :users, only: [:create, :destroy, :index, :show, :update]

  resources :artworks, only: [:create, :destroy, :show, :update]

  resources :artwork_shares, only: [:create, :destroy]

  resources :comments, only: [:create, :destroy]

  resources :users, only: [] do
    resources :artworks, only: [:index]
    resources :comments, only: [:index]
  end

  resources :artworks, only: [] do
    resources :comments, only: [:index]
  end

  resources :users, only: [] do
    get 'favourite', on: :member
  end



end

Rails.application.routes.draw do
  get 'users/new'
  get 'users/create'
  get 'sessions/new'
  get 'sessions/create'
  get 'sessions/destroy'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :ideas do 
    resources :likes, shallow: true, only: [:create, :destroy]
    resources :reviews, only: [:create, :destroy]
  end
  # Defines the root path route ("/")
  # root "articles#index"
  root "ideas#index"

  resource :session, only:[:new, :create, :destroy]
  resources :users, only: [:new, :create]
end

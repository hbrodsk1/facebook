Rails.application.routes.draw do
  devise_for :users
  devise_scope :user do
    root 'devise/sessions#new'
  end

  resources :users, only: [:index, :show] do
    resources :posts
  end
  
  resources :friend_requests
  resources :friends, only: [:index, :destroy]
  resources :posts
  resources :likes
  resources :comments
  get 'about', to: 'static_pages#about'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

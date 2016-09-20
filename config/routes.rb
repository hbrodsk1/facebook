Rails.application.routes.draw do
  resources :friends, only: [:index, :destroy]
  resources :posts

  resources :friend_requests
    devise_for :users
    devise_scope :user do
  		root 'devise/sessions#new'
	end

  resources :users, only: [:index, :show] do
    resources :posts
  end

    get 'about', to: 'static_pages#about'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

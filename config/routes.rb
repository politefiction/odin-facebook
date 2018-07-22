Rails.application.routes.draw do
  get 'comments/create'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'static_pages#home'
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  resources :users do
    resources :posts
  end

  resources :conversations do
    resources :messages, only: [:index, :create]
    get 'messages', on: :member
  end
  resources :friend_requests
  resources :friendships, only: [:create, :destroy]

  get 'users', to: 'users#index'
  get 'profile/:id', to: 'users#show', as: 'profile'
  get 'friends', to: 'users#friends_list', as: 'friends'
end

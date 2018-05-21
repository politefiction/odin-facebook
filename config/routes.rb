Rails.application.routes.draw do
  root 'users#index'
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  get 'users/show', as: "profile"



  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html


end

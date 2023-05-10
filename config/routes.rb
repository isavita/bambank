Rails.application.routes.draw do
  root 'main#home'

  resources :accounts
  devise_for :users
end

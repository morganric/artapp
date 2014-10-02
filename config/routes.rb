Rails.application.routes.draw do
  resources :profiles

  resources :pieces

  mount Upmin::Engine => '/admin'
  root to: 'pieces#index'
  devise_for :users
  resources :users
end

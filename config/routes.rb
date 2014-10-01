Rails.application.routes.draw do
  resources :pieces

  mount Upmin::Engine => '/admin'
  root to: 'pieces#index'
  devise_for :users
  resources :users
end

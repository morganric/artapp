Rails.application.routes.draw do
  resources :profiles
  resources :pieces
  get 'featured' => 'pieces#featured', as: "featured"
  get "/tagged/:tag" => "pieces#tag", :as => :tagged_pieces

  mount Upmin::Engine => '/admin'
  root to: 'pieces#index'
  devise_for :users
  resources :users

  scope ":id" do
    get '', to: 'profiles#show', :as => 'vanity_url'
  end

  get ':user_slug/:id'  => "pieces#show", as: "user_piece"


end

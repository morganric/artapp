Rails.application.routes.draw do
  resources :profiles
  resources :pieces
  get 'featured' => 'pieces#featured', as: "featured"
  get "/tagged/:tag" => "pieces#tag", :as => :tagged_pieces

  post 'user_favs' => 'user_favs#create', :as => 'user_favs'
  delete 'user_favs' => 'user_favs#destroy', :as => 'delete_user_favs'

  mount Upmin::Engine => '/admin'

  devise_for :users
  resources :users

  scope ":id" do
    get '', to: 'profiles#show', :as => 'vanity_url'
  end

  get ':user_slug/:id'  => "pieces#show", as: "user_piece"

  authenticated :user do
        root to: 'pieces#index', as: :authenticated_root
    end

  unauthenticated do
    root to: "visitors#index"
  end

end

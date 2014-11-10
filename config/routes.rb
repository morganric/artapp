Rails.application.routes.draw do

  resources :profiles
  resources :pieces

  get "/facebook" => 'pieces#index', :as => 'facebook', via: [:get, :post]


  get 'p/:id' => 'pieces#show', as: :short
  get 'featured' => 'pieces#featured', as: "featured"
  get "/tagged/:tag" => "pieces#tag", :as => :tagged_pieces

  post 'user_favs' => 'user_favs#create', :as => 'user_favs'
  delete 'user_favs' => 'user_favs#destroy', :as => 'delete_user_favs'

  mount Upmin::Engine => '/admin'

   post "/pieces/:id/dope" => "pieces#dope", :as => "dope", via: [:get, :post]
  post "/pieces/:id/nope" => "pieces#nope", :as => "nope", via: [:get, :post]

  devise_for :users
  resources :users

 scope ":id" do
      get :following, to: "profiles#following", as: 'following_profile'
      get :followers, to: "profiles#followers", as: 'followers_profile'
end

 get 'pages/:id' => 'visitors#index', as: 'static'

  resources :relationships,       only: [:create, :destroy]

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

Rails.application.routes.draw do

  resources :categories

  get 'search' => 'search#index', as: 'search', via: [:get, :post]
  post 'search' => 'search#index', as: 'search_post', via: [:get, :post]

   scope ":id" do
    get :following, to: "profiles#following", as: 'following_profile'
    get :followers, to: "profiles#followers", as: 'followers_profile'
  end



  devise_for :users, :controllers => { :invitations => 'users/invitations', :omniauth_callbacks => "users/omniauth_callbacks" }
  resources :collections

  resources :charges
  resources :profiles
  resources :pieces
     resources :users


  mount Upmin::Engine => '/admin'

  scope "/facebook/:id" do
    get '', to: 'facebook#show', :as => 'facebook_url'
  end

 get ':id/embed' => 'profiles#embed', as: :profile_embed

  get "/tag/:tag" => "pieces#tag", :as => :tagged_pieces
  get "/tag/:tag/embed" => "pieces#tag_embed", :as => :tag_embed


  get "/tagged/:tag" => "pieces#tag", :as => :tag_pieces
  get 'pages/:id' => 'visitors#index', as: 'static'

  # get "/categories" => "pieces#categories", :as => :categories
  # get "/categories/:tag" => "pieces#category", :as => :category
  get "oembed" => "pieces#oembed", constraints: { format: 'json' }, :as => :oembed

   get ':user_slug/:id'  => "pieces#show", as: :user_piece
    get ':user_slug/:id/loved_by'  => "pieces#loved_by", as: :loved_by
   get 'p/:id', to: redirect(':user_slug/:id' ), as: :short

  post '/message' => 'profiles#message', :as => 'message'

  post '/facebook' => 'facebook#index', :as => 'facebook_post', via: [:post]
  get '/facebook' => 'facebook#index', :as => 'facebook_get', via: [:get]
  
  get 'featured' => 'pieces#featured', as: "featured"
  get 'apps' => 'profiles#apps', :as => 'apps'

  post '/facebook_page' => 'facebook_page#create', :as => 'facebook_page'

  scope ":id" do
    get '', to: 'profiles#show', :as => 'vanity_url'
    
  end
  

  scope ":slug/collections/:id" do
    get '', to: 'collections#show', :as => 'user_collection'
  end


  get ':user_slug/collections/:id/embed' => 'collections#embed', as: :collection_embed
  get ':user_slug/collections/:id/player' => 'collections#player', as: :collection_player

  get ':user_slug/:id/embed' => 'pieces#embed', as: :embed
  get ':user_slug/:id/embed.js' => 'pieces#embed', as: :embed_js

  post 'user_favs' => 'user_favs#create', :as => 'user_favs'
  delete 'user_favs' => 'user_favs#destroy', :as => 'delete_user_favs'

  post 'collection_pieces' => 'collection_pieces#create', :as => 'collection_pieces'

  post "/pieces/:id/dope" => "pieces#dope", :as => "dope", via: [:get, :post]
  post "/pieces/:id/nope" => "pieces#nope", :as => "nope", via: [:get, :post]





  resources :relationships,       only: [:create, :destroy]


  authenticated :user do
        root to: 'pieces#index', as: :authenticated_root
    end

  unauthenticated do
    root to: "pieces#index"
  end

end

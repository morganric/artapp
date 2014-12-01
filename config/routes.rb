Rails.application.routes.draw do


  resources :collections

  devise_for :users
  resources :users
  resources :pieces
  resources :profiles


  mount Upmin::Engine => '/admin'

  scope "/facebook/:id" do
    get '', to: 'facebook#show', :as => 'facebook_url'
  end

 scope ":id" do
    get :following, to: "profiles#following", as: 'following_profile'
    get :followers, to: "profiles#followers", as: 'followers_profile'
  end

  

  get "/tagged/:tag" => "pieces#tag", :as => :tagged_pieces
  get 'pages/:id' => 'visitors#index', as: 'static'

  get "/categories" => "pieces#categories", :as => :categories
  get "/categories/:tag" => "pieces#category", :as => :category
  get "oembed" => "pieces#oembed", constraints: { format: 'json' }, :as => :oembed

   get ':user_slug/:id'  => "pieces#show", as: :user_piece
   get 'p/:id', to: redirect(':user_slug/:id' ), as: :short


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
    root to: "visitors#index"
  end

end

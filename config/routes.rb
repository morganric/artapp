Rails.application.routes.draw do

  devise_for :users
  resources :users
  mount Upmin::Engine => '/admin'

    get "/categories" => "pieces#categories", :as => :categories
  get "/categories/:tag" => "pieces#category", :as => :category

  resources :pieces

  scope "/facebook/:id" do
    get '', to: 'facebook#show', :as => 'facebook_url'
  end

  post '/facebook' => 'facebook#index', :as => 'facebook_post', via: [:post]
  get '/facebook' => 'facebook#index', :as => 'facebook_get', via: [:get]
  
  get 'featured' => 'pieces#featured', as: "featured"
  get 'apps' => 'profiles#apps', :as => 'apps'

  post '/facebook_page' => 'facebook_page#create', :as => 'facebook_page'

  
  scope ":id" do
    get '', to: 'profiles#show', :as => 'vanity_url'
  end

  resources :profiles
  

  get ':user_slug/:id/embed' => 'pieces#embed', as: :embed

  get ':user_slug/:id/embed.js' => 'pieces#embed', as: :embed_js

  get 'p/:id' => 'pieces#show', as: :short

  get "/tagged/:tag" => "pieces#tag", :as => :tagged_pieces

  post 'user_favs' => 'user_favs#create', :as => 'user_favs'
  delete 'user_favs' => 'user_favs#destroy', :as => 'delete_user_favs'


   post "/pieces/:id/dope" => "pieces#dope", :as => "dope", via: [:get, :post]
  post "/pieces/:id/nope" => "pieces#nope", :as => "nope", via: [:get, :post]


   scope ":id" do
        get :following, to: "profiles#following", as: 'following_profile'
        get :followers, to: "profiles#followers", as: 'followers_profile'
  end

 get 'pages/:id' => 'visitors#index', as: 'static'

  resources :relationships,       only: [:create, :destroy]


  get ':user_slug/:id'  => "pieces#show", as: "user_piece"

  authenticated :user do
        root to: 'pieces#index', as: :authenticated_root
    end

  unauthenticated do
    root to: "visitors#index"
  end

end

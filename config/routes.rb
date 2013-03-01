Rails.application.routes.draw do

  resources :pages, only: [] do
    get '/preview', to: 'preview#page', as: :preview, on: :member
  end

end

Georgia::Engine.routes.draw do

  mount Ckeditor::Engine => '/ckeditor'

  devise_for :users,
  class_name: "Georgia::User",
  path: '/',
  module: :devise,
  path_names: {sign_in: 'login', sign_out: 'logout', sign_up: 'register'},
  controllers: {sessions: "georgia/users/sessions", registrations: "georgia/users/registrations"}

  devise_scope :user do
    get '/logout', to: 'users/sessions#destroy'
  end


  post "revisions/:id/revert" => "revisions#revert", :as => :revert_version

  resources :pages do
    collection do
      post :sort
      get :search
    end
    member do
      get :ask_for_review
      get :publish
      get :unpublish
    end
  end

  get 'media/tags/:tag', to: 'media#index', as: :tag
  resources :media, path: :media do
    collection do
      delete :destroy_all, to: 'media#destroy_all'
      get :download_all, to: 'media#download_all'
    end
  end
  resources :users
  resources :messages do
    get :search, on: :collection
  end
  resources :menus
  resources :menu_items do
    collection do
      post :add
      post :remove
      post :sort
      post :activate
      post :deactivate
    end
  end

  match '/search/messages', to: 'search#messages'

  root to: 'pages#index'

end
Georgia::Engine.routes.draw do

  devise_for :users,
  class_name: "Georgia::User",
  path: '/',
  module: :devise,
    path_names: {sign_in: 'login', sign_out: 'logout', sign_up: 'register'},
    controllers: {sessions: "georgia/users/sessions", registrations: "georgia/users/registrations"}

  devise_scope :user do
    get '/logout', to: 'users/sessions#destroy'
  end

  resources :pages do
    collection do
      post :sort
      get :search
      get "with_tag/:tag", to: "pages#find_by_tag"
    end
    member do
      get :copy
      get :store
      get :ask_for_review
      get :publish
      get :unpublish
    end
  end

  resources :media, path: :media do
    collection do
      get :search
    end
  end
  resources :users
  resources :messages do
    get :search, on: :collection
  end
  resources :menus

  match '/search/messages', to: 'search#messages'

  root to: 'pages#search'

end

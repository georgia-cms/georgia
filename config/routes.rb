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

  concern :pageable do
    collection do
      post :sort
      get :search
      get "with_tag/:tag", to: :find_by_tag
    end

    member do
      get :preview
      get :draft
      get :publish
      get :unpublish
      get :copy
      get :store
    end

    resources :revisions do
      member do
        get :preview
        get :review
        get :approve
        get :store
        get :decline
        get :unpublish
        get :revert
      end
    end
  end

  resources :pages, concerns: [:pageable]

  resources :media, path: :media do
    collection do
      get :search
    end
  end
  resources :users
  resources :messages do
    collection do
      get :search
    end
    member do
      get :spam
      get :ham
    end
  end
  resources :menus

  match '/search/messages', to: 'search#messages'

  root to: 'pages#search'

end

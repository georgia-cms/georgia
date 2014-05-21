Georgia::Engine.routes.draw do

  devise_for :users, class_name: "Georgia::User", path: '/', module: 'georgia/users', path_names: {sign_in: '/login', sign_out: '/logout'}

  namespace :api do
    resources :media, only: [] do
      collection do
        get :pictures
      end
    end
    resources :tags, only: [] do
      get :search, on: :collection
    end
  end

  concern :pageable do

    collection do
      get :search
      post :sort
      post :publish
      post :unpublish
      post 'flush-cache', to: :flush_cache
      delete '/', to: :destroy
    end

    member do
      get :copy
      get :settings
    end

    resources :revisions do
      member do
        get :preview
        get :review
        get :approve
        get :store
        get :decline
        get :restore
      end
    end
  end

  resources :pages, concerns: [:pageable]

  resources :media, path: :media do
    collection do
      get :search
      post :download
      delete '/', to: :destroy
    end
  end
  resources :users
  resources :menus, path: 'navigation'
  resources :links, only: [:create, :show]
  resources :widgets
  resources :ui_associations, path: 'ui-associations', only: [:new]
  resources :slides, only: [:new]

  # unauthenticated do
  #   as :user do
  #     root to: 'users/sessions#new'
  #   end
  # end
  root to: "dashboard#show"

end

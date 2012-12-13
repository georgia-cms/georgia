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
      match :search
    end
    member do
      match :preview
      match :ask_for_review
      match :publish
      match :unpublish
    end
  end

  get 'media/tags/:tag', to: 'media#index', as: :tag
  resources :media, path: :media do
    collection do
      delete :destroy_all, to: 'media#destroy_all'
    end
  end
  resources :users
  resources :messages do
    match :search, on: :collection
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

  root to: 'messages#new'

end
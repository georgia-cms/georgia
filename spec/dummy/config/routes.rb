Rails.application.routes.draw do

  mount Ckeditor::Engine => '/ckeditor'
  mount Georgia::Engine => '/admin'
  mount Henry::Engine => '/api'

  root to: 'application#index'

  resources :pages do
    get 'preview', on: :member, to: 'pages#preview'
  end

end
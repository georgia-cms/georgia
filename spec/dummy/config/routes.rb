Rails.application.routes.draw do

  mount Georgia::Engine => '/admin'
  mount Ckeditor::Engine => '/ckeditor'

  resources :pages, only: [] do
    get :preview, on: :member
  end

  resources :messages, only: [:create]

  root to: 'pages#show', request_path: 'home'

  get '*request_path', to: 'pages#show', as: :page

end
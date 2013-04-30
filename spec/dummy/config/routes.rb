Rails.application.routes.draw do

  mount Ckeditor::Engine => '/ckeditor'
  mount Georgia::Engine => '/admin'
  mount Henry::Engine => '/api'

  resources :messages, only: [:create]

  resources :pages do
    get 'preview', on: :member, to: 'pages#preview'
  end
  root to: 'pages#show', slug: 'home'

  get '/:slug(/:slug)(/:slug)', to: 'pages#show', as: :page

end
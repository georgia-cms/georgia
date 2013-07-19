Rails.application.routes.draw do

  mount Ckeditor::Engine => '/ckeditor'
  mount Henry::Engine => '/api'
  mount Georgia::Engine => '/admin'

  get '*path', to: 'pages#show', as: :page
  resources :messages, only: [:create]
  root to: 'pages#show', slug: 'home'

end
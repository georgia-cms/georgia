Rails.application.routes.draw do

  mount Ckeditor::Engine => '/ckeditor'

  resources :pages, only: [] do
          post '/preview', to: 'pages#preview', as: :preview, on: :member
        end

  get '/:slug(/:slug)(/:slug)', to: 'pages#show', as: :page

  resources :messages, only: [:create]

  root to: 'pages#show', slug: 'home'

  mount Georgia::Engine => '/admin'
  mount Henry::Engine => '/api'

  root to: 'application#index'
end

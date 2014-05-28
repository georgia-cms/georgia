Rails.application.routes.draw do

  mount Georgia::Engine => '/admin'
  mount Ckeditor::Engine => '/ckeditor'
  get '*request_path', to: 'pages#show', as: :page
  root to: 'pages#show', request_path: 'home'
end

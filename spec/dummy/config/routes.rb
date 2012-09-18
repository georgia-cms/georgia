Rails.application.routes.draw do

  mount Georgia::Engine => '/admin'
  mount Henry::Engine => '/api'

  root to: 'application#index'
end

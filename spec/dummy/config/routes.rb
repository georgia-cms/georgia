Rails.application.routes.draw do

  mount Georgia::Engine => '/admin'

  root to: 'application#index'
end

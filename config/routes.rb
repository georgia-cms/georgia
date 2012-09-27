Georgia::Engine.routes.draw do

  mount Ckeditor::Engine => '/ckeditor'

	devise_for :admins, 
		class_name: "Georgia::Admin",
		path: '/',
		module: :devise,
		path_names: {sign_in: 'login', sign_out: 'logout', sign_up: 'register'},
		controllers: {sessions: "georgia/admins/sessions", registrations: "georgia/admins/registrations"}
	devise_scope :admin do
		get '/logout', to: 'admins/sessions#destroy'
	end

	# post "versions/:id/revert" => "versions#revert", :as => :revert_version
	resources :pages do
		collection do
			post :sort
		end
		member do
			match :preview
			match :ask_for_review
			match :publish
			match :unpublish
		end
	end
	resources :media, path: :media
	resources :admins
	resources :messages
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
	
	root to: 'messages#new'

end
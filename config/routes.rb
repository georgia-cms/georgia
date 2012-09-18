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

	post "versions/:id/revert" => "versions#revert", :as => :revert_version
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

	resources :users
	resources :employees
	resources :employee_directors, controller: :employees
	resources :employee_managers, controller: :employees
	resources :messages
	resources :navigation_menus
	resources :menu_items do
		collection do
			post :add
			post :remove
			post :sort
			post :activate
			post :deactivate
		end
	end
	
	resources :media, path: :media
	get '/', :to => 'messages#new'
	root to: 'messages#new'

end
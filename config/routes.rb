Rails.application.routes.draw do
	
  Mercury::Engine.routes
	root 		 	   "pages#index"
	resources :password_resets,  only: [:new, :create, :edit, :update] 
	resources :appointments
	resources :pages
	resources :users
	resource :user_sessions, 	   only: [:new, :create, :destroy]
	resources :doctors do
		resources :patients
		resources :appontments
	end
	resources :patients do
		resources :appontments
	end
	get    "login"  		=> "user_sessions#new"
	post   "login"  		=> "user_sessions#create"
        delete "logout"  		=> "user_sessions#destroy"
	get    "register"  		=> "patients#new"

end

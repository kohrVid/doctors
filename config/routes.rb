Rails.application.routes.draw do
	
	root 		 	   "pages#index"
	resources :appointments
	resources :pages
	resources :users
	resource :user_sessions, 	   only: [:new, :create, :destroy]
	resources :doctors do
		resources :patients do
			resources :appontments
		end
	end
	resources :patients do
		resources :appontments
	end
	get    "login"  		=> "user_sessions#new"
	post   "login"  		=> "user_sessions#create"
        delete "logout"  		=> "user_sessions#destroy"

end

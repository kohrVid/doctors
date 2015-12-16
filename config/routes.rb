Rails.application.routes.draw do
	
	root 		 	   "pages#index"
	resources :password_resets,  only: [:new, :create, :edit, :update] 
	resources :appointments
	resources :contacts, only: [:new, :create]
	resources :pages
	resources :users
	resources :testimonials
	resource :user_sessions, 	   only: [:new, :create, :destroy]
	resources :doctors do
		resources :patients
		resources :appointments
	end
	resources :patients do
		resources :appointments
	end
	get    "login"  		=> "user_sessions#new"
	post   "login"  		=> "user_sessions#create"
        delete "logout"  		=> "user_sessions#destroy"
	get    "register"  		=> "patients#new"

end

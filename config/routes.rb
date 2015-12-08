Rails.application.routes.draw do
	
    namespace :mercury do
      resources :images
    end
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
	get    "signup"  		=> "users#new"

end

Rails.application.routes.draw do
	
	root 		 	   "pages#index"
	resources :password_resets,  only: [:new, :create, :edit, :update] 
	resources :contacts, only: [:new, :create]
	resources :pages
	resources :users
	resources :testimonials
	resource :user_sessions, 	   only: [:new, :create, :destroy]
	resources :appointments
	resources :doctors do
		resources :patients
		resources :appointments
	end
	resources :patients do
		resources :appointments
	end
	get "/patients/:id/calendar"	=> "patients#calendar"
	get "/doctors/:id/calendar"	=> "doctors#calendar"
	get    "login"  		=> "user_sessions#new"
	post   "login"  		=> "user_sessions#create"
        delete "logout"  		=> "user_sessions#destroy"
	get    "register"  		=> "patients#new"
	get    "bulk_user_approval"	=> "users#bulk_approval"
	get    "bulk_patient_approval"	=> "patients#bulk_approval"
	put   "bulk_user_approved"	=> "users#bulk_user_approved"
	put   "bulk_patient_approved"	=> "patients#bulk_patient_approved"

end

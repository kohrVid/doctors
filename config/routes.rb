Rails.application.routes.draw do
  get 'appointments/index'

  get 'appointments/new'

  get 'appointments/show'

  get 'appointments/edit'

	root 		 	   "pages#index"
	resources :pages
	resources :users
	resource :user_sessions, 	   only: [:new, :create, :destroy]
	get    "login"  		=> "user_sessions#new"
	post   "login"  		=> "user_sessions#create"
        delete "logout"  		=> "user_sessions#destroy"

end

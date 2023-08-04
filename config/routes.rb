Rails.application.routes.draw do
  get 'flights/index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")

  root "flights#index"
  resources :flights, only: [:index]

end

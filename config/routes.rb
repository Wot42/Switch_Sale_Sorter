Rails.application.routes.draw do
  get 'games/show'
  get 'users/show'
  get 'users/baned'
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  resources :users, only: [:show]
  get "/users/:id/baned", to: "users#baned", as: "baned"

end

# rails generate model Games title:string pic:string price:integer sale_price:integer genre:string api_id:string

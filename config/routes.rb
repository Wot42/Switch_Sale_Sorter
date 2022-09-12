Rails.application.routes.draw do
  get 'games/show'
  # get 'users/show'
  get 'users/baned'
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :users, only: [:show]
  get "/banned", to: "users#banned", as: "banned"
  get "/games/updateall", to: "games#update_all"

  delete "/hammers/:id", to: "ban_hammers#destroy", as: "restore"
  post "/games/:id/banhammers", to: "ban_hammers#create", as: "ban"
  get "/games/:id", to: "games#show", as: "game"
end

# rails generate model Games title:string pic:string price:integer sale_price:integer genre:string api_id:string

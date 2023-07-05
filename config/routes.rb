Rails.application.routes.draw do
  devise_for :users
  resources :foods
  resources :users
  resources :recipes
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :inventories
  resources :inventory_foods
  # Defines the root path route ("/")
  # root "articles#index"
end

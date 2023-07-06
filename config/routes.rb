Rails.application.routes.draw do
  devise_for :users
  resources :foods
  resources :users
  resources :recipes
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :inventories do
    resources :inventory_foods
  end

  get 'inventories/:inventory_id/inventory_foods/new', to: 'inventory_foods#new', as: 'new_inventory_food'

  # Defines the root path route ("/")
  # root "articles#index"
end

Rails.application.routes.draw do
  devise_for :users
  root 'users#index'

  resources :foods
  resources :users
  resources :recipes do
    resources :recipe_foods
  end  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  get 'my-recipes', to: 'recipes#my_recipes'
  put '/recipes/:id/toggle_public', to: 'recipes#toggle_public', as: 'toggle_public_recipe'
  get '/recipes/:id/shopping_list', to: 'recipes#shopping_list', as: 'recipe_shopping_list'
  get 'public-recipes', to: 'recipes#public_recipes'
  # root "recipes#my_recipes"
  resources :inventories do
    resources :inventory_foods
  end

  get 'inventories/:inventory_id/inventory_foods/new', to: 'inventory_foods#new', as: 'new_inventory_food'

  # Defines the root path route ("/")
  # root "articles#index"
end

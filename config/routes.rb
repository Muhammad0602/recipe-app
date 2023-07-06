Rails.application.routes.draw do
  devise_for :users
  resources :foods
  resources :users
  resources :recipes do
    resources :recipe_foods
  end  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :inventories
  resources :inventory_foods

  get 'my-recipes', to: 'recipes#my_recipes'
  put '/recipes/:id/toggle_public', to: 'recipes#toggle_public', as: 'toggle_public_recipe'
  get '/recipes/:id/shopping_list', to: 'recipes#shopping_list', as: 'recipe_shopping_list'
  get 'public-recipes', to: 'recipes#public_recipes'
  root "recipes#my_recipes"
  # Defines the root path route ("/")
  # root "articles#index"
end

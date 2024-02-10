Rails.application.routes.draw do
  resources :recipes do
    patch 'toggle_visibility', on: :member
    resources :recipe_foods
  end
  get '/public_recipes', to: 'recipes#public_recipes'
  resources :recipe_foods, only: [:index]
  resources :foods
  devise_for :users
  root to: 'foods#index'
  get "general_shopping_list", to: 'shopping_list#index'
  get "public_recipes", to: 'public_recipe#index'
end
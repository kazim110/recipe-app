Rails.application.routes.draw do
  resources :recipes do
    patch 'toggle_visibility', on: :member
    resources :recipe_foods, only: [:create, :destroy]
  end
  get '/public_recipes', to: 'recipes#public_recipes'

  resources :foods
  devise_for :users

  root to: 'foods#index'

end
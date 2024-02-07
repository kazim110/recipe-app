Rails.application.routes.draw do
  resources :recipe_foods
  resources :recipes
  resources :foods
  devise_for :users

  root to: 'users#index'

  delete '/foods/:id', to: 'foods#destroy', as: 'foods_destroy'

end